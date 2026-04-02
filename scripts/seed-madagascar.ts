import "reflect-metadata";
import fs from "fs";
import path from "path";
import { In } from "typeorm";
import { AppDataSource } from "../src/data-source";
import { Category } from "../src/entities/Category";
import { Entreprise } from "../src/entities/Entreprise";
import { Product } from "../src/entities/Product";
import { Unit } from "../src/entities/Unit";
import { User } from "../src/entities/User";

interface MadagascarProduct {
  id: string;
  reference: string;
  nom: string;
  categorie: string;
  sous_categorie?: string;
  description: string;
  image_url: string;
  prix: {
    achat_ariary: number;
    vente_ariary: number;
    marge_ariary?: number;
    marge_pourcentage?: number;
    devise?: string;
  };
  stock: number;
  unite?: string;
  actif?: boolean;
}

const dataFile = process.argv[2] || path.resolve(process.cwd(), "data/produits_madagascar_1000.json");

if (!fs.existsSync(dataFile)) {
  console.error(`Fichier JSON introuvable : ${dataFile}`);
  console.error("Placez le fichier dans harena-back/data/produits_madagascar_1000.json ou passez son chemin en argument.");
  process.exit(1);
}

const rawData = fs.readFileSync(dataFile, "utf-8");
const parsed = JSON.parse(rawData) as { produits: MadagascarProduct[] };
const products = parsed.produits.filter((item) => item.actif !== false);

async function resolveSeedEntrepriseId() {
  const explicitId = Number(process.env.SEED_ENTREPRISE_ID || process.env.ENTREPRISE_ID || 0);
  if (explicitId > 0) {
    return explicitId;
  }

  const userRepo = AppDataSource.getRepository(User);
  const entrepriseRepo = AppDataSource.getRepository(Entreprise);

  const userWithEntreprise = await userRepo
    .createQueryBuilder("u")
    .where("u.entrepriseId IS NOT NULL AND u.entrepriseId != 0")
    .limit(1)
    .getOne();

  if (userWithEntreprise?.entrepriseId) {
    return userWithEntreprise.entrepriseId;
  }

  const existingEntreprise = await entrepriseRepo.findOne({ order: { id: "ASC" } });
  if (existingEntreprise) {
    return existingEntreprise.id;
  }

  const newEntreprise = entrepriseRepo.create({
    name: "Seed Entreprise",
    managerName: "Seed Admin",
    email: "seed@example.com",
    phone: "0000000000",
    activity: "Seed",
    teamSize: "1",
  });
  await entrepriseRepo.save(newEntreprise);
  console.log("Création d'une entreprise de seed par défaut :", newEntreprise.id);
  return newEntreprise.id;
}

async function seed() {
  await AppDataSource.initialize();
  const entrepriseId = await resolveSeedEntrepriseId();
  const categoryRepo = AppDataSource.getRepository(Category);
  const unitRepo = AppDataSource.getRepository(Unit);
  const productRepo = AppDataSource.getRepository(Product);

  const categoryNames = Array.from(new Set(products.map((item) => item.categorie).filter(Boolean)));
  const existingCategories = await categoryRepo.find({ where: { name: In(categoryNames) } });
  const categoryMap = new Map(existingCategories.map((category) => [category.name, category]));

  const newCategories = categoryNames
    .filter((name) => !categoryMap.has(name))
    .map((name) => {
      const category = new Category();
      category.name = name;
      category.description = `${name} générée automatiquement`;
      return category;
    });

  if (newCategories.length > 0) {
    const savedCategories = await categoryRepo.save(newCategories);
    savedCategories.forEach((category) => categoryMap.set(category.name, category));
  }

  const unitNames = Array.from(new Set(products.map((item) => item.unite).filter(Boolean)));
  const existingUnits = await unitRepo.find({ where: { name: In(unitNames) } });
  const unitMap = new Map(existingUnits.map((unit) => [unit.name, unit]));

  const newUnits = unitNames
    .filter((name) => !unitMap.has(name))
    .map((name) => {
      const unit = new Unit();
      unit.name = name;
      unit.abbreviation = name;
      unit.entrepriseId = entrepriseId;
      return unit;
    });

  if (newUnits.length > 0) {
    const savedUnits = await unitRepo.save(newUnits);
    savedUnits.forEach((unit) => unitMap.set(unit.name, unit));
  }

  for (const item of products) {
    const category = categoryMap.get(item.categorie) || null;
    const unit = item.unite ? unitMap.get(item.unite) || null : null;
    const existing = await productRepo.findOne({ where: { name: item.nom, entrepriseId } });
    const product = existing ?? new Product();

    product.name = item.nom;
    product.description = item.description;
    product.image = item.image_url;
    product.buyPrice = Number(item.prix?.achat_ariary || 0);
    product.sellPrice = Number(item.prix?.vente_ariary || 0);
    product.stock = Number(item.stock || 0);
    product.entrepriseId = entrepriseId;
    product.archived = false;
    product.category = category;
    product.unit = unit;

    await productRepo.save(product);
    console.log(`${existing ? "Updated" : "Inserted"}: ${product.name}`);
  }

  console.log(`Seed terminé : ${products.length} produits Madagascar importés.`);
  await AppDataSource.destroy();
}

seed().catch((error) => {
  console.error("Erreur de seed Madagascar :", error);
  process.exit(1);
});
