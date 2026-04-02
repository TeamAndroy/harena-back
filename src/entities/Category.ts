import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, OneToMany } from "typeorm";
import { Product } from "./Product";

@Entity()
export class Category {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ default: false })
  archived: boolean;

  @Column({ nullable: true })
  description: string;

  @OneToMany(() => Product, (p) => p.category)
  products: Product[];

  @CreateDateColumn()
  createdAt: Date;
}
