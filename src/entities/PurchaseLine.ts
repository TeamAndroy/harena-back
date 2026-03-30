import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from "typeorm";
import { Purchase } from "./Purchase";
import { Product } from "./Product";

@Entity()
export class PurchaseLine {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Purchase, (p) => p.lines)
  @JoinColumn()
  purchase: Purchase;

  @ManyToOne(() => Product, { eager: true })
  @JoinColumn()
  product: Product;

  @Column("int")
  quantity: number;

  @Column("decimal", { precision: 15, scale: 2 })
  unitPrice: number;

  @Column("decimal", { precision: 15, scale: 2 })
  total: number;
}
