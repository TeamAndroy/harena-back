import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, OneToMany, JoinColumn } from "typeorm";
import { Client } from "./Client";
import { SaleLine } from "./SaleLine";
import { Payment } from "./Payment";

@Entity()
export class Sale {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ default: 0 })
  entrepriseId: number;

  @Column({ default: false })
  archived: boolean;

  @Column()
  reference: string;

  @ManyToOne(() => Client, { nullable: true, eager: true })
  @JoinColumn()
  client: Client;

  @Column({ nullable: true })
  notes: string;

  @Column("decimal", { precision: 15, scale: 2, default: 0 })
  totalAmount: number;

  @Column("decimal", { precision: 15, scale: 2, default: 0 })
  totalPaid: number;

  @Column({ default: "pending" })
  paymentStatus: string; // pending, partial, paid

  @OneToMany(() => SaleLine, (sl) => sl.sale, { cascade: true, eager: true })
  lines: SaleLine[];

  @OneToMany(() => Payment, (p) => p.sale, { cascade: true, eager: true })
  payments: Payment[];

  @CreateDateColumn()
  createdAt: Date;
}
