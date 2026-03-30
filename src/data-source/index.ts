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

export const AppDataSource = new DataSource({
  type: "sqlite",
  database: "./gsp.db",
  synchronize: true,
  logging: false,
  entities: [User, Entreprise, Product, Category, Unit, Client, Sale, SaleLine, Payment, Purchase, PurchaseLine, Expense],
});
