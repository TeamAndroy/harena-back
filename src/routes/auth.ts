import { Router } from "express";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { AppDataSource } from "../data-source";
import { User } from "../entities/User";
import { Entreprise } from "../entities/Entreprise";
import { Unit } from "../entities/Unit";

const router = Router();
const JWT_SECRET = process.env.JWT_SECRET || "gsp_secret_2024";

function slugifyPart(value: string) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/[^a-z]/g, "");
}

async function buildUsername(fullName: string) {
  const userRepo = AppDataSource.getRepository(User);
  const parts = fullName
    .trim()
    .split(/\s+/)
    .map(slugifyPart)
    .filter(Boolean);

  const firstName = parts[0] || "";
  const lastName = parts[parts.length - 1] || "";
  const fallback = `user${Date.now().toString().slice(-5)}`;
  const base = `${lastName.slice(0, 1)}${firstName}` || fallback;

  let username = base;
  let suffix = 1;

  while (await userRepo.findOne({ where: { username } })) {
    username = `${base}${suffix}`;
    suffix += 1;
  }

  return username;
}

router.post("/login", async (req, res) => {
  try {
    const { username, password } = req.body;
    const userRepo = AppDataSource.getRepository(User);
    const user = await userRepo.findOne({ where: { username } });
    if (!user) return res.status(401).json({ message: "Identifiants invalides" });
    const valid = await bcrypt.compare(password, user.password);
    if (!valid) return res.status(401).json({ message: "Identifiants invalides" });
    const token = jwt.sign(
      { id: user.id, username: user.username, role: user.role, entrepriseId: user.entrepriseId ?? null },
      JWT_SECRET,
      { expiresIn: "7d" }
    );
    res.json({
      token,
      user: {
        id: user.id,
        username: user.username,
        role: user.role,
        entrepriseId: user.entrepriseId ?? null,
      },
    });
  } catch (e) {
    res.status(500).json({ message: "Erreur serveur" });
  }
});

router.post("/register", async (req, res) => {
  try {
    const { companyName, managerName, email, phone, activity, teamSize, password } = req.body;
    const userRepo = AppDataSource.getRepository(User);
    const entrepriseRepo = AppDataSource.getRepository(Entreprise);
    const unitRepo = AppDataSource.getRepository(Unit);

    if (!companyName || !managerName || !email || !phone || !activity || !teamSize || !password) {
      return res.status(400).json({ message: "Veuillez renseigner tous les champs obligatoires" });
    }

    const username = await buildUsername(managerName);
    const hashed = await bcrypt.hash(password, 10);

    const entreprise = entrepriseRepo.create({
      name: companyName,
      managerName,
      email,
      phone,
      activity,
      teamSize,
    });

    await entrepriseRepo.save(entreprise);

    await unitRepo.save([
      unitRepo.create({ entrepriseId: entreprise.id, name: "Piece", abbreviation: "pcs" }),
      unitRepo.create({ entrepriseId: entreprise.id, name: "Kilogramme", abbreviation: "kg" }),
      unitRepo.create({ entrepriseId: entreprise.id, name: "Litre", abbreviation: "L" }),
    ]);

    const user = userRepo.create({
      username,
      password: hashed,
      fullName: managerName,
      entrepriseId: entreprise.id,
      entreprise,
    });

    await userRepo.save(user);

    res.json({
      message: "Compte cree",
      user: { id: user.id, username: user.username, role: user.role, entrepriseId: entreprise.id },
      entreprise: { id: entreprise.id, name: entreprise.name },
    });
  } catch (e) {
    res.status(500).json({ message: "Erreur serveur" });
  }
});

export default router;
