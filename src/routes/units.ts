import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Unit } from "../entities/Unit";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

async function ensureDefaultUnits(entrepriseId: number) {
  const repo = AppDataSource.getRepository(Unit);
  const count = await repo.count({ where: { entrepriseId } });

  if (count > 0) return;

  await repo.save([
    repo.create({ entrepriseId, name: "Piece", abbreviation: "pcs" }),
    repo.create({ entrepriseId, name: "Kilogramme", abbreviation: "kg" }),
    repo.create({ entrepriseId, name: "Litre", abbreviation: "L" }),
  ]);
}

router.get("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Unit);
    await ensureDefaultUnits(entrepriseId);
    const units = await repo.find({ where: { entrepriseId }, order: { name: "ASC" } });
    res.json(units);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.post("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Unit);
    const unit = repo.create({ ...req.body, entrepriseId });
    await repo.save(unit);
    res.json(unit);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Unit);
    const unit = await repo.findOne({ where: { id: parseInt(req.params.id), entrepriseId } });
    if (!unit) return res.status(404).json({ message: "Introuvable" });
    repo.merge(unit, { ...req.body, entrepriseId });
    await repo.save(unit);
    res.json(unit);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Unit);
    const result = await repo.delete({ id: parseInt(req.params.id), entrepriseId });
    if (!result.affected) return res.status(404).json({ message: "Introuvable" });
    res.json({ message: "Supprime" });
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

export default router;
