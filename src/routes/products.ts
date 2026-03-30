import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Product } from "../entities/Product";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

router.get("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Product);
    const { search, category, stock } = req.query;

    let qb = repo
      .createQueryBuilder("p")
      .leftJoinAndSelect("p.category", "c")
      .leftJoinAndSelect("p.unit", "u")
      .where("p.entrepriseId = :entrepriseId", { entrepriseId });

    if (search) qb = qb.andWhere("p.name LIKE :s", { s: `%${search}%` });
    if (category && category !== "all") qb = qb.andWhere("c.id = :cid", { cid: category });
    if (stock === "low") qb = qb.andWhere("p.stock <= 5");
    if (stock === "out") qb = qb.andWhere("p.stock = 0");

    const products = await qb.orderBy("p.name", "ASC").getMany();
    res.json(products);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Product);
    const p = await repo.findOne({ where: { id: parseInt(req.params.id), entrepriseId } });
    if (!p) return res.status(404).json({ message: "Produit introuvable" });
    res.json(p);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.post("/", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Product);
    const p = repo.create({ ...req.body, entrepriseId });
    await repo.save(p);
    res.json(p);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Product);
    const p = await repo.findOne({ where: { id: parseInt(req.params.id), entrepriseId } });
    if (!p) return res.status(404).json({ message: "Produit introuvable" });
    repo.merge(p, { ...req.body, entrepriseId });
    await repo.save(p);
    res.json(p);
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const entrepriseId = requireEntrepriseId(req);
    const repo = AppDataSource.getRepository(Product);
    const result = await repo.delete({ id: parseInt(req.params.id), entrepriseId });
    if (!result.affected) return res.status(404).json({ message: "Produit introuvable" });
    res.json({ message: "Supprime" });
  } catch (e) {
    res.status((e as any).status || 500).json({ message: (e as Error).message || "Erreur" });
  }
});

export default router;
