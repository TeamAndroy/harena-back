import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Sale } from "../entities/Sale";
import { SaleLine } from "../entities/SaleLine";
import { Payment } from "../entities/Payment";
import { Product } from "../entities/Product";
import { Client } from "../entities/Client";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Sale);
    const { from, to, client, status } = req.query;

    let qb = repo
      .createQueryBuilder("s")
      .leftJoinAndSelect("s.client", "c")
      .leftJoinAndSelect("s.lines", "l")
      .leftJoinAndSelect("l.product", "p")
      .leftJoinAndSelect("s.payments", "pay")
      .where("s.entrepriseId = :entrepriseId", { entrepriseId });

    if (from) qb = qb.andWhere("s.createdAt >= :from", { from });
    if (to) qb = qb.andWhere("s.createdAt <= :to", { to: to + " 23:59:59" });
    if (client) qb = qb.andWhere("c.name LIKE :cl", { cl: `%${client}%` });
    if (status) qb = qb.andWhere("s.paymentStatus = :st", { st: status });

    const sales = await qb.orderBy("s.createdAt", "DESC").getMany();
    res.json(sales);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Sale);
    const sale = await repo
      .createQueryBuilder("s")
      .leftJoinAndSelect("s.client", "c")
      .leftJoinAndSelect("s.lines", "l")
      .leftJoinAndSelect("l.product", "p")
      .leftJoinAndSelect("s.payments", "pay")
      .where("s.id = :id", { id: parseInt(req.params.id) })
      .andWhere("s.entrepriseId = :entrepriseId", { entrepriseId })
      .getOne();

    if (!sale) return res.status(404).json({ message: "Introuvable" });
    res.json(sale);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.post("/", async (req, res) => {
  const queryRunner = AppDataSource.createQueryRunner();
  await queryRunner.connect();
  await queryRunner.startTransaction();

  try {
    const entrepriseId = requireEntrepriseId(req);
    const { clientId, notes, lines, payment } = req.body;

    const count = await queryRunner.manager.count(Sale, { where: { entrepriseId } });
    const ref = `${String(count + 1).padStart(4, "0")}/${new Date().getFullYear().toString().slice(-2)}`;

    let total = 0;
    const saleLines: SaleLine[] = [];

    for (const line of lines || []) {
      const product = await queryRunner.manager.findOne(Product, {
        where: { id: line.productId, entrepriseId },
      });

      if (!product) throw new Error(`Produit ${line.productId} introuvable`);
      if (product.stock < line.quantity) throw new Error(`Stock insuffisant pour ${product.name}`);

      const lineTotal = line.quantity * line.unitPrice;
      total += lineTotal;

      const saleLine = new SaleLine();
      saleLine.product = product;
      saleLine.quantity = line.quantity;
      saleLine.unitPrice = line.unitPrice;
      saleLine.total = lineTotal;
      saleLines.push(saleLine);

      product.stock -= line.quantity;
      await queryRunner.manager.save(product);
    }

    const sale = new Sale();
    sale.reference = ref;
    sale.entrepriseId = entrepriseId;
    sale.notes = notes;
    sale.totalAmount = total;
    sale.lines = saleLines;

    if (clientId) {
      const client = await queryRunner.manager.findOne(Client, {
        where: { id: clientId, entrepriseId },
      });
      if (!client) throw new Error("Client introuvable");
      sale.client = client;
    }

    let totalPaid = 0;
    if (payment && payment.amount > 0) {
      const pay = new Payment();
      pay.amount = payment.amount;
      pay.method = payment.method || "cash";
      pay.reference = payment.reference;
      sale.payments = [pay];
      totalPaid = payment.amount;
    } else {
      sale.payments = [];
    }

    sale.totalPaid = totalPaid;
    sale.paymentStatus = totalPaid >= total ? "paid" : totalPaid > 0 ? "partial" : "pending";

    await queryRunner.manager.save(sale);
    await queryRunner.commitTransaction();
    res.json(sale);
  } catch (e: any) {
    await queryRunner.rollbackTransaction();
    res.status((e as any).status || 400).json({ message: e.message || "Erreur" });
  } finally {
    await queryRunner.release();
  }
});

router.post("/:id/payment", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const saleRepo = AppDataSource.getRepository(Sale);
    const payRepo = AppDataSource.getRepository(Payment);
    const sale = await saleRepo.findOne({
      where: { id: parseInt(req.params.id), entrepriseId },
      relations: ["payments"],
    });

    if (!sale) return res.status(404).json({ message: "Introuvable" });

    const { amount, method, reference } = req.body;
    const pay = payRepo.create({ sale, amount, method, reference });
    await payRepo.save(pay);

    sale.totalPaid = Number(sale.totalPaid) + Number(amount);
    sale.paymentStatus = sale.totalPaid >= sale.totalAmount ? "paid" : "partial";
    await saleRepo.save(sale);

    res.json(sale);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.delete("/:id", async (req, res) => {
  const queryRunner = AppDataSource.createQueryRunner();
  await queryRunner.connect();
  await queryRunner.startTransaction();

  try {
    const entrepriseId = requireEntrepriseId(req);
    const saleRepo = queryRunner.manager.getRepository(Sale);
    const sale = await saleRepo.findOne({
      where: { id: parseInt(req.params.id), entrepriseId },
      relations: ["lines", "lines.product"],
    });

    if (!sale) return res.status(404).json({ message: "Introuvable" });

    for (const line of sale.lines) {
      const product = await queryRunner.manager.findOne(Product, {
        where: { id: line.product.id, entrepriseId },
      });

      if (product) {
        product.stock += line.quantity;
        await queryRunner.manager.save(product);
      }
    }

    await queryRunner.manager.delete(Sale, { id: sale.id, entrepriseId });
    await queryRunner.commitTransaction();
    res.json({ message: "Supprime" });
  } catch (e) {
    await queryRunner.rollbackTransaction();
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  } finally {
    await queryRunner.release();
  }
});

export default router;
