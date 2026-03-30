import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Category } from "../entities/Category";
import { authMiddleware } from "../middleware/auth";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const repo = AppDataSource.getRepository(Category);
    const cats = await repo.find({ order: { name: "ASC" } });
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
    await repo.delete(parseInt(req.params.id));
    res.json({ message: "Supprimé" });
  } catch (e) {
    res.status(500).json({ message: "Erreur" });
  }
});

export default router;
