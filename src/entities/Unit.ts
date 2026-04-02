import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from "typeorm";

@Entity()
export class Unit {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ default: 0 })
  entrepriseId: number;

  @Column({ default: false })
  archived: boolean;

  @Column()
  name: string;

  @Column({ nullable: true })
  abbreviation: string;

  @CreateDateColumn()
  createdAt: Date;
}
