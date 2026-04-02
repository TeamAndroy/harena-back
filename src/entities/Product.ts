import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from "typeorm";
import { Category } from "./Category";
import { Unit } from "./Unit";

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  description: string;

  @Column("text", { nullable: true })
  image: string;

  @Column("decimal", { precision: 15, scale: 2, default: 0 })
  buyPrice: number;

  @Column("decimal", { precision: 15, scale: 2, default: 0 })
  sellPrice: number;

  @Column("int", { default: 0 })
  stock: number;

  @Column({ default: 0 })
  entrepriseId: number;

  @Column({ default: false })
  archived: boolean;

  @ManyToOne(() => Category, { nullable: true, eager: true })
  @JoinColumn()
  category: Category;

  @ManyToOne(() => Unit, { nullable: true, eager: true })
  @JoinColumn()
  unit: Unit;

  @CreateDateColumn()
  createdAt: Date;
}
