import { Router } from "express";
import { AppDataSource } from "../data-source";
import { Product } from "../entities/Product";
import { Category } from "../entities/Category";
import { Unit } from "../entities/Unit";
import { authMiddleware } from "../middleware/auth";
import { requireEntrepriseId } from "../utils/entreprise";

const router = Router();
router.use(authMiddleware);

const hydrateProductRelations = async (body: any) => {
  const data = { ...body };
  const categoryRepo = AppDataSource.getRepository(Category);
  const unitRepo = AppDataSource.getRepository(Unit);

  if (body.categoryId) {
    const category = await categoryRepo.findOne({ where: { id: Number(body.categoryId) } });
    if (!category) {
      throw new Error("Catégorie introuvable");
    }
    data.category = category;
  } else {
    data.category = null;
  }

  if (body.unitId) {
    const unit = await unitRepo.findOne({ where: { id: Number(body.unitId) } });
    if (!unit) {
      throw new Error("Unité introuvable");
    }
    data.unit = unit;
  } else {
    data.unit = null;
  }

  delete data.categoryId;
  delete data.unitId;

  return data;
};

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
    if (stock === "low") qb = qb.andWhere("p.stock <= 5 AND p.stock > 0");
    if (stock === "out") qb = qb.andWhere("p.stock <= 0");

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
    const data = await hydrateProductRelations(req.body);
    const p = repo.create({ ...data, entrepriseId });
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

    const data = await hydrateProductRelations(req.body);
    repo.merge(p, { ...data, entrepriseId });
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
