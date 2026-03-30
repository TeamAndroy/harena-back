import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn, CreateDateColumn } from "typeorm";
import { Sale } from "./Sale";

@Entity()
export class Payment {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Sale, (s) => s.payments)
  @JoinColumn()
  sale: Sale;

  @Column("decimal", { precision: 15, scale: 2 })
  amount: number;

  @Column({ default: "cash" })
  method: string; // cash, check, transfer

  @Column({ nullable: true })
  reference: string;

  @CreateDateColumn()
  createdAt: Date;
}
