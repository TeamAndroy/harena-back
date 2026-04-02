import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from "typeorm";
import { Sale } from "./Sale";
import { Product } from "./Product";

@Entity()
export class SaleLine {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Sale, (s) => s.lines, { onDelete: "CASCADE" })
  @JoinColumn()
  sale: Sale;

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
