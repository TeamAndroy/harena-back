import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from "typeorm";

@Entity()
export class Expense {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ default: 0 })
  entrepriseId: number;

  @Column({ default: false })
  archived: boolean;

  @Column()
  label: string;

  @Column({ nullable: true })
  description: string;

  @Column("decimal", { precision: 15, scale: 2 })
  amount: number;

  @Column({ nullable: true })
  category: string;

  @CreateDateColumn()
  createdAt: Date;
}
