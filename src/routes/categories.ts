import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Category } from "../entities/Category";
import { authMiddleware } from "../middleware/auth";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const repo = AppDataSource.getRepository(Category);
    const cats = await repo.find({ where: { archived: false }, order: { name: "ASC" } });
    res.json(cats);
  } catch (e) {
    res.status(500).json({ message: "Erreur" });
  }
});

router.post("/", async (req, res) => {
  try {
    const repo = AppDataSource.getRepository(Category);
    const c = repo.create(req.body);
    await repo.save(c);
    res.json(c);
  } catch (e) {
    res.status(500).json({ message: "Erreur" });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const repo = AppDataSource.getRepository(Category);
    const c = await repo.findOne({ where: { id: parseInt(req.params.id) } });
    if (!c) return res.status(404).json({ message: "Introuvable" });
    repo.merge(c, req.body);
    await repo.save(c);
    res.json(c);
  } catch (e) {
    res.status(500).json({ message: "Erreur" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const repo = AppDataSource.getRepository(Category);
    const result = await repo.update({ id: parseInt(req.params.id) }, { archived: true });
    if (!result.affected) return res.status(404).json({ message: "Introuvable" });
    res.json({ message: "Archivé" });
  } catch (e) {
    res.status(500).json({ message: "Erreur" });
  }
});

export default router;
