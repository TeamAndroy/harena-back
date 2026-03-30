import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Sale } from "../entities/Sale";
import { Purchase } from "../entities/Purchase";
import { Expense } from "../entities/Expense";
import { Product } from "../entities/Product";
import { SaleLine } from "../entities/SaleLine";
import { PurchaseLine } from "../entities/PurchaseLine";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const productRepo = AppDataSource.getRepository(Product);
    const saleRepo = AppDataSource.getRepository(Sale);
    const purchaseRepo = AppDataSource.getRepository(Purchase);
    const expenseRepo = AppDataSource.getRepository(Expense);

    const products = await productRepo.find({ where: { entrepriseId } });
    const stockBuyValue = products.reduce((s, p) => s + Number(p.buyPrice) * p.stock, 0);
    const stockSellValue = products.reduce((s, p) => s + Number(p.sellPrice) * p.stock, 0);

    const now = new Date();
    const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);

    const salesMonth = await saleRepo
      .createQueryBuilder("s")
      .where("s.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("s.createdAt >= :start", { start: startOfMonth })
      .getMany();
    const totalSales = salesMonth.reduce((s, v) => s + Number(v.totalAmount), 0);

    const purchasesMonth = await purchaseRepo
      .createQueryBuilder("p")
      .where("p.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("p.createdAt >= :start", { start: startOfMonth })
      .getMany();
    const totalPurchases = purchasesMonth.reduce((s, v) => s + Number(v.totalAmount), 0);

    const expensesMonth = await expenseRepo
      .createQueryBuilder("e")
      .where("e.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("e.createdAt >= :start", { start: startOfMonth })
      .getMany();
    const totalExpenses = expensesMonth.reduce((s, v) => s + Number(v.amount), 0);

    const recentSales = await saleRepo.find({
      where: { entrepriseId },
      order: { createdAt: "DESC" },
      take: 10,
      relations: ["lines", "lines.product"],
    });

    res.json({
      stockBuyValue,
      stockSellValue,
      potentialProfit: stockSellValue - stockBuyValue,
      productCount: products.length,
      totalSales,
      totalPurchases,
      totalExpenses,
      netProfit: totalSales - totalPurchases - totalExpenses,
      recentMovements: recentSales
        .flatMap((sale) =>
          sale.lines.map((line) => ({
            product: line.product.name,
            type: "sale",
            quantity: -line.quantity,
            reference: sale.reference,
            date: sale.createdAt,
          }))
        )
        .slice(0, 10),
    });
  } catch (e) {
    console.error(e);
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.get("/top-sales", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const { from, to } = req.query;

    let qb = AppDataSource.getRepository(SaleLine)
      .createQueryBuilder("sl")
      .leftJoin("sl.sale", "s")
      .leftJoinAndSelect("sl.product", "p")
      .select("p.id", "productId")
      .addSelect("p.name", "productName")
      .addSelect("SUM(sl.quantity)", "totalQty")
      .addSelect("SUM(sl.total)", "totalAmount")
      .where("s.entrepriseId = :entrepriseId", { entrepriseId })
      .groupBy("p.id")
      .orderBy("totalQty", "DESC");

    if (from) qb = qb.andWhere("s.createdAt >= :from", { from });
    if (to) qb = qb.andWhere("s.createdAt <= :to", { to: to + " 23:59:59" });

    const results = await qb.getRawMany();
    res.json(results);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.get("/etat-gestion", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const { year, month } = req.query;
    const y = parseInt(year as string) || new Date().getFullYear();
    const m = parseInt(month as string) || new Date().getMonth() + 1;
    const start = new Date(y, m - 1, 1);
    const end = new Date(y, m, 0, 23, 59, 59);

    const products = await AppDataSource.getRepository(Product).find({
      where: { entrepriseId },
      relations: ["unit"],
    });

    const saleLines = await AppDataSource.getRepository(SaleLine)
      .createQueryBuilder("sl")
      .leftJoin("sl.sale", "s")
      .leftJoinAndSelect("sl.product", "p")
      .where("s.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("s.createdAt BETWEEN :start AND :end", { start, end })
      .getMany();

    const purchaseLines = await AppDataSource.getRepository(PurchaseLine)
      .createQueryBuilder("pl")
      .leftJoin("pl.purchase", "pu")
      .leftJoinAndSelect("pl.product", "p")
      .where("pu.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("pu.createdAt BETWEEN :start AND :end", { start, end })
      .getMany();

    const rows = products.map((product) => {
      const sold = saleLines.filter((saleLine) => saleLine.product.id === product.id);
      const bought = purchaseLines.filter((purchaseLine) => purchaseLine.product.id === product.id);
      const qteVendue = sold.reduce((sum, saleLine) => sum + saleLine.quantity, 0);
      const qteAchat = bought.reduce((sum, purchaseLine) => sum + purchaseLine.quantity, 0);
      const totalVente = sold.reduce((sum, saleLine) => sum + Number(saleLine.total), 0);

      return {
        id: product.id,
        name: product.name,
        unit: product.unit?.name || "pcs",
        createdAt: product.createdAt,
        qteInitiale: product.stock + qteVendue - qteAchat,
        qteAchat,
        qteVendue,
        qteRestante: product.stock,
        totalVente,
      };
    });

    res.json(rows);
  } catch (e) {
    console.error(e);
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.get("/movements", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);

    const saleLines = await AppDataSource.getRepository(SaleLine)
      .createQueryBuilder("sl")
      .leftJoinAndSelect("sl.sale", "s")
      .leftJoinAndSelect("sl.product", "p")
      .where("s.entrepriseId = :entrepriseId", { entrepriseId })
      .orderBy("s.createdAt", "DESC")
      .take(50)
      .getMany();

    const purchaseLines = await AppDataSource.getRepository(PurchaseLine)
      .createQueryBuilder("pl")
      .leftJoinAndSelect("pl.purchase", "pu")
      .leftJoinAndSelect("pl.product", "p")
      .where("pu.entrepriseId = :entrepriseId", { entrepriseId })
      .orderBy("pu.createdAt", "DESC")
      .take(50)
      .getMany();

    const movements = [
      ...saleLines.map((saleLine) => ({
        product: saleLine.product.name,
        type: "sale",
        quantity: -saleLine.quantity,
        unit: saleLine.product.unit?.abbreviation || "u",
        reference: saleLine.sale.reference,
        date: saleLine.sale.createdAt,
      })),
      ...purchaseLines.map((purchaseLine) => ({
        product: purchaseLine.product.name,
        type: "purchase",
        quantity: purchaseLine.quantity,
        unit: purchaseLine.product.unit?.abbreviation || "u",
        reference: purchaseLine.purchase.reference,
        date: purchaseLine.purchase.createdAt,
      })),
    ]
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
      .slice(0, 50);

    res.json(movements);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

export default router;
