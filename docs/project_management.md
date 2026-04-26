# Gestion de projet — Movies ELK Platform

## 1. Équipe

| Membre | Rôle | Features |
|---|---|---|
| Nassim Benchikh | Lead & Data | F4 - Mapping, F5 - Requêtes DSL, F7 - Documentation |
| Harold Lerner | Infrastructure & Moteur | F1 - Bootstrap stack, F2 - Ingestion brute, F3 - Nettoyage, F8 - Moteur de recherche |
| Rodrigue Harnais | Dashboard | F6 - Dashboard Kibana, F7 - Documentation |

---

## 2. Gitflow

Branches utilisées :
- `main` — version stable finale
- `dev` — branche d'intégration commune
- `feature/*` — branches de développement par feature

Règles appliquées :
- push direct sur `main` et `dev` interdit
- toute feature passe par une PR
- minimum 1 reviewer par PR

> **Note** : Les PR #1 et #2 ont été mergées directement dans `main` au lieu de `dev`. Les PR suivantes respectent le Gitflow en mergeant dans `dev`.

---

## 3. Pull Requests

| PR | Branche | Description | Auteur | Statut |
|---|---|---|---|---|
| #1 | Feature/BaseConfig | Docker Compose, start.sh, stop.sh, .gitignore | Harold Lerner | Mergée dans main |
| #2 | Feature/CleanIngestion | Pipeline Logstash, movies_raw et movies_clean | Harold Lerner | Mergée dans main |
| #3 | feature/mapping-data-quality | Mapping explicite, data_cleaning.md, dataset | Nassim Benchikh | Mergée dans dev |
| #4 | feature/queries | 12 requêtes DSL commentées | Nassim Benchikh | Mergée dans dev |
| #5 | feature/documentation | data_dictionary.md, runbook.md, planning_poker.md | Nassim Benchikh | Mergée dans dev |
| #6 | feature/dashboard-kibana | Dashboard Kibana, dashboard.ndjson | Rodrigue Harnais | Mergée dans dev |
| #7 | feature/moteur-recherche | Mini moteur de recherche + demo | Harold Lerner | ✗ à compléter par Harold |

---

## 4. Ordre de réalisation

1. Bootstrap stack (F1)
2. Ingestion brute (F2)
3. Nettoyage et normalisation (F3)
4. Mapping et qualité data (F4)
5. Requêtes analytiques (F5)
6. Dashboard Kibana (F6)
7. Documentation (F7)
8. Moteur de recherche (F8)