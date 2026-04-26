# Dictionnaire de données — Movies Clean


## Contexte

**TMDB** (The Movie Database) est une base de données collaborative en ligne qui recense des informations sur les films, séries et personnes du monde du cinéma. 

Le dataset utilisé est un export de 4803 films extraits de l'API TMDB, contenant des métadonnées complètes comme les genres, les studios de production, les budgets, les revenues et les notes des utilisateurs.

## Source
Dataset : `tmdb_5000_movies.csv`  
Source : [Kaggle TMDB Movie Metadata](https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata)  
Index Elasticsearch : `movies_clean`  
Nombre de documents : 4802 (4803 ingérés dans movies_raw, 1 document rejeté car incompatible avec le mapping)

---

## Description des champs

| Champ                  | Type ES | Description                 | Exemple                         | Valeurs manquantes |
| ---------------------- | ------- | --------------------------- | ------------------------------- | ------------------ |
| `id`                   | integer | Identifiant unique du film  | `278`                           | 0                  |
| `title`                | text    | Titre du film               | `"The Shawshank Redemption"`    | 0                  |
| `original_title`       | text    | Titre original              | `"The Shawshank Redemption"`    | 0                  |
| `original_language`    | keyword | Langue originale (code ISO) | `"en"`                          | 0                  |
| `overview`             | text    | Synopsis du film            | `"Framed in the 1940s..."`      | 0                  |
| `popularity`           | float   | Score de popularité TMDB    | `136.74`                        | 0                  |
| `release_date`         | date    | Date de sortie              | `1994-09-23`                    | 0                  |
| `budget`               | integer | Budget en dollars           | `25000000`                      | 0                  |
| `revenue`              | integer | Recettes en dollars         | `28341469`                      | 0                  |
| `runtime`              | integer | Durée en minutes            | `142`                           | 0                  |
| `status`               | keyword | Statut du film              | `"Released"`                    | 0                  |
| `tagline`              | text    | Slogan du film              | `"Fear can hold you prisoner."` | 0                  |
| `vote_average`         | float   | Note moyenne (0-10)         | `8.5`                           | 0                  |
| `vote_count`           | integer | Nombre de votes             | `8205`                          | 0                  |
| `genres`               | keyword | Liste des genres            | `["Drama", "Crime"]`            | 0                  |
| `keywords`             | keyword | Liste des mots-clés         | `["prison", "corruption"]`      | 0                  |
| `production_companies` | keyword | Studios de production       | `["Castle Rock Entertainment"]` | 0                  |
| `production_countries` | keyword | Pays de production          | `["United States of America"]`  | 0                  |
| `spoken_languages`     | keyword | Langues parlées             | `["English"]`                   | 0                  |

---

## Valeurs notables

### `original_language`
Les langues les plus représentées dans le dataset :

| Langue   | Code | Nombre de films |
| -------- | ---- | --------------- |
| Anglais  | `en` | majoritaire     |
| Français | `fr` | présent         |
| Espagnol | `es` | présent         |
| Japonais | `ja` | présent         |

### `status`
Valeurs possibles : `Released`, `In Production`, `Post Production`, `Planned`, `Canceled`, `Rumored`

### `vote_average`
Score entre 0 et 10. Les films avec `vote_count` < 100 peuvent avoir des notes peu fiables.

### `budget` / `revenue`
Les valeurs à 0 signifient que la donnée n'est pas renseignée, elles ont été conservées telles quelles dans `movies_clean` car Logstash ne les remplace pas par `null`.