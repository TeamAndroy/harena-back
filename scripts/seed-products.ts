import "reflect-metadata";
import { In } from "typeorm";
import { AppDataSource } from "../src/data-source";
import { Category } from "../src/entities/Category";
import { Entreprise } from "../src/entities/Entreprise";
import { Product } from "../src/entities/Product";
import { User } from "../src/entities/User";

const products = [
  {
    name: "Chaussures running Nike style",
    category: "Chaussures",
    price_cost_mga: 120000,
    price_sale_mga: 180000,
    description: "Chaussures de sport légères adaptées au running quotidien.",
    image_url: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80"
  },
  {
    name: "Smartphone Android 128GB",
    category: "Électronique",
    price_cost_mga: 800000,
    price_sale_mga: 1200000,
    description: "Smartphone performant avec écran HD et grande autonomie.",
    image_url: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9"
  },
  {
    name: "Télévision LED 43 pouces",
    category: "Électronique",
    price_cost_mga: 1800000,
    price_sale_mga: 2500000,
    description: "TV écran plat avec résolution Full HD.",
    image_url: "https://images.unsplash.com/photo-1593784991095-a205069470b6"
  },
  {
    name: "Sac à dos ordinateur",
    category: "Accessoires",
    price_cost_mga: 50000,
    price_sale_mga: 90000,
    description: "Sac robuste avec compartiment laptop.",
    image_url: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62"
  },
  {
    name: "Montre connectée",
    category: "Wearables",
    price_cost_mga: 220000,
    price_sale_mga: 350000,
    description: "Montre intelligente avec suivi de santé.",
    image_url: "https://images.unsplash.com/photo-1511732351157-1865efcb7b7b"
  },
  {
    name: "Casque Bluetooth",
    category: "Audio",
    price_cost_mga: 70000,
    price_sale_mga: 120000,
    description: "Casque sans fil avec réduction de bruit.",
    image_url: "https://images.unsplash.com/photo-1518444065439-e933c06ce9cd"
  },
  {
    name: "Ordinateur portable 15 pouces",
    category: "Informatique",
    price_cost_mga: 1500000,
    price_sale_mga: 2100000,
    description: "Laptop performant pour travail et études.",
    image_url: "https://images.unsplash.com/photo-1517336714731-489689fd1ca8"
  },
  {
    name: "Clavier mécanique RGB",
    category: "Informatique",
    price_cost_mga: 90000,
    price_sale_mga: 150000,
    description: "Clavier gamer avec rétroéclairage RGB.",
    image_url: "https://images.unsplash.com/photo-1518770660439-4636190af475"
  },
  {
    name: "Souris gaming",
    category: "Informatique",
    price_cost_mga: 40000,
    price_sale_mga: 80000,
    description: "Souris ergonomique haute précision.",
    image_url: "https://images.unsplash.com/photo-1587829741301-dc798b83add3"
  },
  {
    name: "Power bank 20000mAh",
    category: "Accessoires",
    price_cost_mga: 50000,
    price_sale_mga: 85000,
    description: "Batterie externe grande capacité.",
    image_url: "https://images.unsplash.com/photo-1585386959984-a4155224a1ad"
  },
  {
    name: "T-shirt coton",
    category: "Mode",
    price_cost_mga: 15000,
    price_sale_mga: 30000,
    description: "T-shirt confortable en coton.",
    image_url: "https://images.unsplash.com/photo-1523381210434-271e8be1f52b"
  },
  {
    name: "Jean homme",
    category: "Mode",
    price_cost_mga: 40000,
    price_sale_mga: 80000,
    description: "Jean durable coupe moderne.",
    image_url: "https://images.unsplash.com/photo-1541099649105-f69ad21f3246"
  },
  {
    name: "Chaussures casual",
    category: "Mode",
    price_cost_mga: 60000,
    price_sale_mga: 110000,
    description: "Chaussures stylées pour usage quotidien.",
    image_url: "https://images.unsplash.com/photo-1528701800489-20be3c1f6b7b"
  },
  {
    name: "Lunettes de soleil",
    category: "Accessoires",
    price_cost_mga: 20000,
    price_sale_mga: 45000,
    description: "Protection UV avec design moderne.",
    image_url: "https://images.unsplash.com/photo-1511499767150-a48a237f0083"
  },
  {
    name: "Casquette",
    category: "Mode",
    price_cost_mga: 10000,
    price_sale_mga: 25000,
    description: "Casquette légère et respirante.",
    image_url: "https://images.unsplash.com/photo-1521369909029-2afed882baee"
  },
  {
    name: "Chaise bureau",
    category: "Maison",
    price_cost_mga: 120000,
    price_sale_mga: 200000,
    description: "Chaise ergonomique pour bureau.",
    image_url: "https://images.unsplash.com/photo-1586023492125-27b2c045efd7"
  },
  {
    name: "Table en bois",
    category: "Maison",
    price_cost_mga: 200000,
    price_sale_mga: 350000,
    description: "Table solide en bois naturel.",
    image_url: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85"
  },
  {
    name: "Lampe LED",
    category: "Maison",
    price_cost_mga: 25000,
    price_sale_mga: 60000,
    description: "Lampe moderne basse consommation.",
    image_url: "https://images.unsplash.com/photo-1507473885765-e6ed057f782c"
  },
  {
    name: "Mixeur électrique",
    category: "Électroménager",
    price_cost_mga: 70000,
    price_sale_mga: 120000,
    description: "Mixeur puissant pour cuisine.",
    image_url: "https://images.unsplash.com/photo-1586201375761-83865001e31c"
  },
  {
    name: "Bouilloire électrique",
    category: "Électroménager",
    price_cost_mga: 30000,
    price_sale_mga: 70000,
    description: "Bouilloire rapide et efficace.",
    image_url: "https://images.unsplash.com/photo-1606813909353-3b3d3f4b4c1a"
  },
  {
    name: "Ballon de football",
    category: "Sport",
    price_cost_mga: 20000,
    price_sale_mga: 45000,
    description: "Ballon résistant pour terrain.",
    image_url: "https://images.unsplash.com/photo-1517649763962-0c623066013b"
  },
  {
    name: "Tapis de yoga",
    category: "Sport",
    price_cost_mga: 30000,
    price_sale_mga: 60000,
    description: "Tapis antidérapant fitness.",
    image_url: "https://images.unsplash.com/photo-1554306274-f23873d9a26c"
  },
  {
    name: "Haltères fitness",
    category: "Sport",
    price_cost_mga: 50000,
    price_sale_mga: 90000,
    description: "Poids pour entraînement musculaire.",
    image_url: "https://images.unsplash.com/photo-1599058917765-a780eda07a3e"
  },
  {
    name: "Bouteille isotherme",
    category: "Sport",
    price_cost_mga: 15000,
    price_sale_mga: 35000,
    description: "Garde boissons chaudes/froides.",
    image_url: "https://images.unsplash.com/photo-1526401485004-2fa806b6f3b1"
  },
  {
    name: "Sac de sport",
    category: "Sport",
    price_cost_mga: 40000,
    price_sale_mga: 80000,
    description: "Sac spacieux pour activités sportives.",
    image_url: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438"
  },
  {
    name: "Parfum homme",
    category: "Beauté",
    price_cost_mga: 60000,
    price_sale_mga: 120000,
    description: "Parfum longue durée.",
    image_url: "https://images.unsplash.com/photo-1541643600914-78b084683601"
  },
  {
    name: "Crème visage",
    category: "Beauté",
    price_cost_mga: 20000,
    price_sale_mga: 50000,
    description: "Crème hydratante peau.",
    image_url: "https://images.unsplash.com/photo-1556228578-0d85b1a4d571"
  },
  {
    name: "Shampooing",
    category: "Beauté",
    price_cost_mga: 10000,
    price_sale_mga: 25000,
    description: "Shampooing nourrissant.",
    image_url: "https://images.unsplash.com/photo-1585238342028-4b5f7f58f09d"
  },
  {
    name: "Savon liquide",
    category: "Beauté",
    price_cost_mga: 8000,
    price_sale_mga: 20000,
    description: "Savon doux pour la peau.",
    image_url: "https://images.unsplash.com/photo-1583947215259-38e31be8751f"
  },
  {
    name: "Brosse à dents électrique",
    category: "Hygiène",
    price_cost_mga: 40000,
    price_sale_mga: 90000,
    description: "Brosse rechargeable efficace.",
    image_url: "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5"
  }
];

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
  const productRepo = AppDataSource.getRepository(Product);

  const categoryNames = Array.from(new Set(products.map((p) => p.category)));
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

  for (const item of products) {
    const category = categoryMap.get(item.category) || null;
    const existing = await productRepo.findOne({ where: { name: item.name, entrepriseId } });
    const product = existing ?? new Product();

    product.name = item.name;
    product.description = item.description;
    product.image = item.image_url;
    product.buyPrice = item.price_cost_mga;
    product.sellPrice = item.price_sale_mga;
    product.stock = 0;
    product.entrepriseId = entrepriseId;
    product.category = category;
    product.archived = false;

    await productRepo.save(product);
    console.log(`${existing ? "Updated" : "Inserted"}: ${product.name}`);
  }

  console.log(`Seed terminé : ${products.length} produits traités.`);
  await AppDataSource.destroy();
}

seed().catch((error) => {
  console.error("Erreur de seed :", error);
  process.exit(1);
});
