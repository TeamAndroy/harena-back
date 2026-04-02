import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Purchase } from "../entities/Purchase";
import { PurchaseLine } from "../entities/PurchaseLine";
import { Product } from "../entities/Product";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Purchase);
    const { from, to, supplier } = req.query;

    let qb = repo
      .createQueryBuilder("p")
      .leftJoinAndSelect("p.lines", "l")
      .leftJoinAndSelect("l.product", "pr")
      .where("p.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("p.archived = false");

    if (from) qb = qb.andWhere("p.createdAt >= :from", { from });
    if (to) qb = qb.andWhere("p.createdAt <= :to", { to: to + " 23:59:59" });
    if (supplier) qb = qb.andWhere("p.supplier LIKE :s", { s: `%${supplier}%` });

    const purchases = await qb.orderBy("p.createdAt", "DESC").getMany();
    res.json(purchases);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Purchase);
    const purchase = await repo
      .createQueryBuilder("p")
      .leftJoinAndSelect("p.lines", "l")
      .leftJoinAndSelect("l.product", "pr")
      .where("p.id = :id", { id: parseInt(req.params.id) })
      .andWhere("p.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("p.archived = false")
      .getOne();

    if (!purchase) return res.status(404).json({ message: "Introuvable" });
    res.json(purchase);
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
    const { supplier, notes, lines, amountPaid } = req.body;

    const count = await queryRunner.manager.count(Purchase, { where: { entrepriseId } });
    const ref = `${String(count + 1).padStart(4, "0")}/${new Date().getFullYear().toString().slice(-2)}`;

    let total = 0;
    const purchaseLines: PurchaseLine[] = [];

    for (const line of lines || []) {
      const product = await queryRunner.manager.findOne(Product, {
        where: { id: line.productId, entrepriseId },
      });

      if (!product) throw new Error("Produit introuvable");

      const lineTotal = line.quantity * line.unitPrice;
      total += lineTotal;

      const purchaseLine = new PurchaseLine();
      purchaseLine.product = product;
      purchaseLine.quantity = line.quantity;
      purchaseLine.unitPrice = line.unitPrice;
      purchaseLine.total = lineTotal;
      purchaseLines.push(purchaseLine);

      product.stock += line.quantity;
      await queryRunner.manager.save(product);
    }

    const purchase = new Purchase();
    purchase.reference = ref;
    purchase.entrepriseId = entrepriseId;
    purchase.supplier = supplier;
    purchase.notes = notes;
    purchase.totalAmount = total;
    purchase.totalPaid = amountPaid || 0;
    purchase.paymentStatus = (amountPaid || 0) >= total ? "paid" : (amountPaid || 0) > 0 ? "partial" : "pending";
    purchase.lines = purchaseLines;

    await queryRunner.manager.save(purchase);
    await queryRunner.commitTransaction();
    res.json(purchase);
  } catch (e: any) {
    await queryRunner.rollbackTransaction();
    res.status((e as any).status || 400).json({ message: e.message || "Erreur" });
  } finally {
    await queryRunner.release();
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Purchase);
    const purchase = await repo.findOne({
      where: { id: parseInt(req.params.id), entrepriseId, archived: false },
    });

    if (!purchase) return res.status(404).json({ message: "Introuvable" });

    purchase.archived = true;
    await repo.save(purchase);
    res.json({ message: "Archivé" });
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

export default router;
