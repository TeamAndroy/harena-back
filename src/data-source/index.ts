import "reflect-metadata";
import { DataSource } from "typeorm";
import { User } from "../entities/User";
import { Product } from "../entities/Product";
import { Category } from "../entities/Category";
import { Unit } from "../entities/Unit";
import { Client } from "../entities/Client";
import { Sale } from "../entities/Sale";
import { SaleLine } from "../entities/SaleLine";
import { Payment } from "../entities/Payment";
import { Purchase } from "../entities/Purchase";
import { PurchaseLine } from "../entities/PurchaseLine";
import { Expense } from "../entities/Expense";
import { Entreprise } from "../entities/Entreprise";

const dbType = process.env.DB_TYPE?.toLowerCase() || "postgres";
const useSqlite = dbType === "sqlite";

const dbHost = process.env.DB_HOST || process.env.POSTGRES_HOST || "localhost";
const dbPort = Number(process.env.DB_PORT || process.env.POSTGRES_PORT || 5432);
const dbUser = process.env.DB_USER || process.env.POSTGRES_USER || "postgres";
const dbPassword = process.env.DB_PASSWORD || process.env.POSTGRES_PASSWORD || "harena_db_pass";
const dbName = process.env.DB_NAME || process.env.POSTGRES_DB || "harena_db";
const defaultPostgresUrl = `postgresql://${dbUser}:${dbPassword}@${dbHost}:${dbPort}/${dbName}`;

export const AppDataSource = new DataSource(
  useSqlite
    ? {
        type: "sqlite",
        database: "./gsp.db",
        synchronize: true,
        logging: false,
        entities: [User, Entreprise, Product, Category, Unit, Client, Sale, SaleLine, Payment, Purchase, PurchaseLine, Expense],
      }
    : {
        type: "postgres",
        url: process.env.DATABASE_URL || process.env.DB_URL || defaultPostgresUrl,
        synchronize: true,
        logging: false,
        entities: [User, Entreprise, Product, Category, Unit, Client, Sale, SaleLine, Payment, Purchase, PurchaseLine, Expense],
      }
);
