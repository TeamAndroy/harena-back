import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, OneToMany } from "typeorm";
import { User } from "./User";

@Entity()
export class Entreprise {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  managerName: string;

  @Column()
  email: string;

  @Column()
  phone: string;

  @Column()
  activity: string;

  @Column()
  teamSize: string;

  @CreateDateColumn()
  createdAt: Date;

  @OneToMany(() => User, (user) => user.entreprise)
  users: User[];
}
