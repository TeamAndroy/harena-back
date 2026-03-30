# Harena Backend

API Express + TypeORM pour la gestion commerciale Harena.

## Stack
- Node.js
- Express
- TypeScript
- TypeORM
- SQLite
- JWT

## Lancement

```bash
npm install
npm run dev
```

Le serveur demarre sur `http://localhost:3001`.

## Mode multi-entreprise

Le backend isole maintenant les donnees par entreprise.

- Chaque utilisateur peut etre rattache a une `entreprise`.
- Le JWT embarque `id`, `username`, `role` et `entrepriseId`.
- Les routes suivantes sont filtrees par `entrepriseId` :
  - `products`
  - `units`
  - `clients`
  - `expenses`
  - `sales`
  - `purchases`
  - `stats`
- Les `categories` restent globales et partagees entre toutes les entreprises.

## Comportement a l'inscription

L'inscription entreprise sur `/api/auth/register` cree :

- l'entreprise
- l'utilisateur principal
- des unites par defaut pour cette entreprise (`Piece`, `Kilogramme`, `Litre`)

## Compatibilite anciennes sessions

Pour eviter des `403` apres l'ajout du multi-entreprise :

- le middleware d'auth recharge `entrepriseId` depuis la base si un ancien token ne le contient pas encore
- un utilisateur sans entreprise restera bloque sur les routes privees a l'entreprise

## Endpoints principaux

| Methode | Route | Description |
|---|---|---|
| POST | `/api/auth/login` | Connexion |
| POST | `/api/auth/register` | Inscription entreprise |
| GET/POST/PUT/DELETE | `/api/products` | Produits de l'entreprise |
| GET/POST/PUT/DELETE | `/api/categories` | Categories partagees |
| GET/POST/PUT/DELETE | `/api/units` | Unites de l'entreprise |
| GET/POST/PUT/DELETE | `/api/clients` | Clients de l'entreprise |
| GET/POST/DELETE | `/api/sales` | Ventes de l'entreprise |
| POST | `/api/sales/:id/payment` | Paiement d'une vente de l'entreprise |
| GET/POST/DELETE | `/api/purchases` | Achats de l'entreprise |
| GET/POST/PUT/DELETE | `/api/expenses` | Depenses de l'entreprise |
| GET | `/api/stats` | Tableau de bord de l'entreprise |
| GET | `/api/stats/top-sales` | Top ventes de l'entreprise |
| GET | `/api/stats/etat-gestion` | Etat de gestion de l'entreprise |
| GET | `/api/stats/movements` | Mouvements de l'entreprise |

## Note migration

Les anciennes donnees non rattachees a une entreprise ne seront plus visibles tant qu'elles ne sont pas reassociees a une entreprise cible.
