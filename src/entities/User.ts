import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from "typeorm";
import { Entreprise } from "./Entreprise";

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ unique: true })
  username: string;

  @Column()
  password: string;

  @Column({ default: "admin" })
  role: string;

  @Column({ nullable: true })
  fullName: string;

  @Column({ nullable: true })
  entrepriseId: number;

  @ManyToOne(() => Entreprise, (entreprise) => entreprise.users, { nullable: true, onDelete: "SET NULL" })
  @JoinColumn({ name: "entrepriseId" })
  entreprise: Entreprise;

  @CreateDateColumn()
  createdAt: Date;
}
