import "reflect-metadata";
import express from "express";
import cors from "cors";
import { AppDataSource } from "./data-source";
import authRoutes from "./routes/auth";
import productRoutes from "./routes/products";
import categoryRoutes from "./routes/categories";
import unitRoutes from "./routes/units";
import clientRoutes from "./routes/clients";
import saleRoutes from "./routes/sales";
import purchaseRoutes from "./routes/purchases";
import expenseRoutes from "./routes/expenses";
import statsRoutes from "./routes/stats";
import bcrypt from "bcryptjs";
import { User } from "./entities/User";
import { Category } from "./entities/Category";
import { Unit } from "./entities/Unit";

const app = express();
app.use(cors());
app.use(express.json({ limit: "10mb" }));

app.use("/api/auth", authRoutes);
app.use("/api/products", productRoutes);
app.use("/api/categories", categoryRoutes);
app.use("/api/units", unitRoutes);
app.use("/api/clients", clientRoutes);
app.use("/api/sales", saleRoutes);
app.use("/api/purchases", purchaseRoutes);
app.use("/api/expenses", expenseRoutes);
app.use("/api/stats", statsRoutes);

const PORT = process.env.PORT || 3001;

AppDataSource.initialize().then(async () => {
  console.log("✅ Database connected");

  // Seed default user
  const userRepo = AppDataSource.getRepository(User);
  const exists = await userRepo.findOne({ where: { username: "admin" } });
  if (!exists) {
    const hashed = await bcrypt.hash("admin123", 10);
    await userRepo.save(userRepo.create({ username: "admin", password: hashed }));
    console.log("✅ Default user created: admin / admin123");
  }

  // Seed default category
  const catRepo = AppDataSource.getRepository(Category);
  const catCount = await catRepo.count();
  if (catCount === 0) {
    await catRepo.save(catRepo.create({ name: "Général", description: "Catégorie générale" }));
  }

  // Seed default unit
  const unitRepo = AppDataSource.getRepository(Unit);
  const unitCount = await unitRepo.count();
  if (unitCount === 0) {
    await unitRepo.save(unitRepo.create({ name: "Pièce", abbreviation: "pcs" }));
    await unitRepo.save(unitRepo.create({ name: "Kilogramme", abbreviation: "kg" }));
    await unitRepo.save(unitRepo.create({ name: "Litre", abbreviation: "L" }));
  }

  app.listen(PORT, () => {
    console.log(`🚀 Server running on http://localhost:${PORT}`);
  });
}).catch((err) => {
  console.error("❌ Database error:", err);
});
