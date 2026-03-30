import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import { AppDataSource } from "../data-source";
import { User } from "../entities/User";

const JWT_SECRET = process.env.JWT_SECRET || "gsp_secret_2024";

export const authMiddleware = async (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ message: "Non autorise" });
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET) as any;

    if (!decoded?.id) {
      return res.status(401).json({ message: "Token invalide" });
    }

    let entrepriseId = decoded.entrepriseId ?? null;

    // Old tokens may not include entrepriseId yet, so reload it from the user record.
    if (!entrepriseId && AppDataSource.isInitialized) {
      const user = await AppDataSource.getRepository(User).findOne({
        where: { id: Number(decoded.id) },
      });

      entrepriseId = user?.entrepriseId ?? null;
    }

    (req as any).user = {
      ...decoded,
      entrepriseId,
    };

    next();
  } catch {
    return res.status(401).json({ message: "Token invalide" });
  }
};
