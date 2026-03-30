import { Request } from "express";

export function getEntrepriseId(req: Request) {
  return Number((req as any).user?.entrepriseId || 0);
}

export function requireEntrepriseId(req: Request) {
  const entrepriseId = getEntrepriseId(req);

  if (!entrepriseId) {
    const error = new Error("Aucune entreprise associee a cet utilisateur");
    (error as any).status = 403;
    throw error;
  }

  return entrepriseId;
}
