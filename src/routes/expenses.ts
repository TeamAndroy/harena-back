import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Expense } from "../entities/Expense";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Expense);
    const { from, to } = req.query;

    let qb = repo.createQueryBuilder("e").where("e.entrepriseId = :entrepriseId", { entrepriseId });
    if (from) qb = qb.andWhere("e.createdAt >= :from", { from });
    if (to) qb = qb.andWhere("e.createdAt <= :to", { to: to + " 23:59:59" });

    const expenses = await qb.orderBy("e.createdAt", "DESC").getMany();
    res.json(expenses);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.post("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Expense);
    const expense = repo.create({ ...req.body, entrepriseId });
    await repo.save(expense);
    res.json(expense);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Expense);
    const expense = await repo.findOne({ where: { id: parseInt(req.params.id), entrepriseId } });
    if (!expense) return res.status(404).json({ message: "Introuvable" });
    repo.merge(expense, { ...req.body, entrepriseId });
    await repo.save(expense);
    res.json(expense);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Expense);
    const result = await repo.delete({ id: parseInt(req.params.id), entrepriseId });
    if (!result.affected) return res.status(404).json({ message: "Introuvable" });
    res.json({ message: "Supprime" });
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

export default router;
