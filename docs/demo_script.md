# Demo Script — Movies ELK Platform

## Prérequis

- Docker Desktop lancé
- Stack démarrée via `./start.sh`
- Fichier `search.html` ouvert dans le navigateur

---

## Étape 1 — Recherche full-text

1. Ouvrir `search.html` dans le navigateur
2. Taper **"Avengers"** dans la barre de recherche
3. Observer les 24 résultats — The Avengers, Avengers: Age of Ultron, etc.
4. Chaque carte affiche : titre, note, année, durée, langue, genres

## Étape 2 — Filtre par genre

1. Dans la sidebar, sélectionner **"Action"** dans le dropdown Genre
2. Observer que les résultats se filtrent automatiquement
3. Seuls les films Avengers classés en Action apparaissent

## Étape 3 — Filtre par langue

1. Réinitialiser le genre sur "Tous les genres"
2. Sélectionner **"Anglais"** dans le dropdown Langue
3. Observer le filtrage par langue originale

## Étape 4 — Recherche vide avec filtre

1. Vider la barre de recherche
2. Sélectionner **"Science Fiction"** dans Genre
3. Observer tous les films de Science Fiction du dataset

---

## Ce que démontre la démo

- Recherche full-text connectée à Elasticsearch (`movies_clean`)
- Fuzzy matching — tolère les fautes de frappe
- Filtres exacts par genre et par langue
- Résultats en temps réel sans rechargement de page


> Pour visualiser la démo : ouvrir `demo.gif` dans un navigateur (Safari, Chrome, Firefox).