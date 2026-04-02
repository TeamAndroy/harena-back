import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Client } from "../entities/Client";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Client);
    const { search } = req.query;

    let qb = repo
      .createQueryBuilder("c")
      .where("c.entrepriseId = :entrepriseId", { entrepriseId })
      .andWhere("c.archived = false");

    if (search) qb = qb.andWhere("(c.name LIKE :s OR c.phone LIKE :s)", { s: `%${search}%` });

    const clients = await qb.orderBy("c.name", "ASC").getMany();
    res.json(clients);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.post("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Client);
    const c = repo.create({ ...req.body, entrepriseId });
    await repo.save(c);
    res.json(c);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Client);
    const c = await repo.findOne({ where: { id: parseInt(req.params.id), entrepriseId } });
    if (!c) return res.status(404).json({ message: "Introuvable" });
    repo.merge(c, { ...req.body, entrepriseId });
    await repo.save(c);
    res.json(c);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Client);
    const result = await repo.update({ id: parseInt(req.params.id), entrepriseId }, { archived: true });
    if (!result.affected) return res.status(404).json({ message: "Introuvable" });
    res.json({ message: "Archivé" });
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

export default router;
