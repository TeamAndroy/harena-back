import "reflect-metadata";
import express from "express";
import cors from "cors";
import swaggerUi from "swagger-ui-express";
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

const API_PREFIX = "/api/v1";
const PORT = process.env.PORT || 3001;

const swaggerDocument = {
  openapi: "3.0.0",
  info: {
    title: "Harena API",
    version: "1.0.0",
    description: "Documentation Swagger de l'API Harena version 1",
  },
  servers: [
    {
      url: `http://localhost:${PORT}${API_PREFIX}`,
      description: "Serveur local",
    },
  ],
  components: {
    securitySchemes: {
      BearerAuth: {
        type: "http",
        scheme: "bearer",
        bearerFormat: "JWT",
      },
    },
  },
  security: [{ BearerAuth: [] }],
  paths: {
    "/auth/login": {
      post: {
        tags: ["Auth"],
        summary: "Connexion utilisateur",
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: {
                type: "object",
                properties: {
                  username: { type: "string" },
                  password: { type: "string" },
                },
                required: ["username", "password"],
              },
            },
          },
        },
        responses: {
          "200": { description: "Connecté avec succès" },
          "401": { description: "Identifiants invalides" },
        },
      },
    },
    "/auth/register": {
      post: {
        tags: ["Auth"],
        summary: "Créer un nouvel utilisateur et entreprise",
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: {
                type: "object",
                properties: {
                  companyName: { type: "string" },
                  managerName: { type: "string" },
                  email: { type: "string" },
                  phone: { type: "string" },
                  activity: { type: "string" },
                  teamSize: { type: "string" },
                  password: { type: "string" },
                },
                required: ["companyName", "managerName", "email", "phone", "activity", "teamSize", "password"],
              },
            },
          },
        },
        responses: {
          "201": { description: "Inscription réussie" },
          "400": { description: "Données invalides" },
        },
      },
    },
    "/categories": {
      get: {
        tags: ["Categories"],
        summary: "Liste des catégories",
        responses: { "200": { description: "Liste récupérée" } },
      },
      post: {
        tags: ["Categories"],
        summary: "Créer une catégorie",
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: {
                type: "object",
                properties: {
                  name: { type: "string" },
                  description: { type: "string" },
                },
                required: ["name"],
              },
            },
          },
        },
        responses: { "201": { description: "Catégorie créée" } },
      },
    },
    "/products": {
      get: {
        tags: ["Products"],
        summary: "Liste des produits",
        responses: { "200": { description: "Liste récupérée" } },
      },
    },
    "/sales": {
      get: {
        tags: ["Sales"],
        summary: "Liste des ventes",
        responses: { "200": { description: "Liste récupérée" } },
      },
      post: {
        tags: ["Sales"],
        summary: "Créer une vente",
        responses: { "201": { description: "Vente créée" } },
      },
    },
    "/purchases": {
      get: {
        tags: ["Purchases"],
        summary: "Liste des achats",
        responses: { "200": { description: "Liste récupérée" } },
      },
    },
    "/expenses": {
      get: {
        tags: ["Expenses"],
        summary: "Liste des dépenses",
        responses: { "200": { description: "Liste récupérée" } },
      },
    },
    "/units": {
      get: {
        tags: ["Units"],
        summary: "Liste des unités",
        responses: { "200": { description: "Liste récupérée" } },
      },
    },
    "/clients": {
      get: {
        tags: ["Clients"],
        summary: "Liste des clients",
        responses: { "200": { description: "Liste récupérée" } },
      },
    },
    "/stats": {
      get: {
        tags: ["Stats"],
        summary: "Statistiques de l'application",
        responses: { "200": { description: "Statistiques récupérées" } },
      },
    },
  },
};

app.use(`${API_PREFIX}/auth`, authRoutes);
app.use(`${API_PREFIX}/products`, productRoutes);
app.use(`${API_PREFIX}/categories`, categoryRoutes);
app.use(`${API_PREFIX}/units`, unitRoutes);
app.use(`${API_PREFIX}/clients`, clientRoutes);
app.use(`${API_PREFIX}/sales`, saleRoutes);
app.use(`${API_PREFIX}/purchases`, purchaseRoutes);
app.use(`${API_PREFIX}/expenses`, expenseRoutes);
app.use(`${API_PREFIX}/stats`, statsRoutes);
app.use(`${API_PREFIX}/docs`, swaggerUi.serve, swaggerUi.setup(swaggerDocument));
app.get(`${API_PREFIX}/docs.json`, (_, res) => res.json(swaggerDocument));

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
