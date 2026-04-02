import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, OneToMany, JoinColumn } from "typeorm";
import { PurchaseLine } from "./PurchaseLine";

@Entity()
export class Purchase {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ default: 0 })
  entrepriseId: number;

  @Column({ default: false })
  archived: boolean;

  @Column()
  reference: string;

  @Column({ nullable: true })
  supplier: string;

  @Column("decimal", { precision: 15, scale: 2, default: 0 })
  totalAmount: number;

  @Column("decimal", { precision: 15, scale: 2, default: 0 })
  totalPaid: number;

  @Column({ default: "pending" })
  paymentStatus: string;

  @Column({ nullable: true })
  notes: string;

  @OneToMany(() => PurchaseLine, (pl) => pl.purchase, { cascade: true, eager: true })
  lines: PurchaseLine[];

  @CreateDateColumn()
  createdAt: Date;
}
