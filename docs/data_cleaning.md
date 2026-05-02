# Documentation du nettoyage des données

## 1. Source des données
Dataset : `tmdb_5000_movies.csv`  
Source : [Kaggle TMDB Movie Metadata](https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata)  
Nombre de documents bruts : 4803

---

## 2. Mesure d'impact avant/après

| Index          | Nombre de documents | Taille |
| -------------- | ------------------- | ------ |
| `movies_raw`   | 4803                | ~10 MB |
| `movies_clean` | 4802                | ~6 MB  |

**RQ :** 1 document rejeté (données invalide surement)

---

## 3. Règles de nettoyage appliquées (Logstash)

### Conversion de types

| Champ          | Avant  | Après   | Raison                |
| -------------- | ------ | ------- | --------------------- |
| `id`           | string | integer | identifiant numérique |
| `budget`       | string | integer | valeur monétaire      |
| `revenue`      | string | integer | valeur monétaire      |
| `runtime`      | string | integer | durée en minutes      |
| `vote_count`   | string | integer | nombre entier         |
| `popularity`   | string | float   | score décimal         |
| `vote_average` | string | float   | note décimale         |
| `release_date` | string | date    | format yyyy-MM-dd     |

### Normalisation des champs liste

Les champs suivants étaient stockés en JSON string et ont été parsés en tableaux :

| Champ                  | Avant                            | Après                |
| ---------------------- | -------------------------------- | -------------------- |
| `genres`               | `[{"id": 28, "name": "Action"}]` | `["Action"]`         |
| `keywords`             | `[{"id": 1, "name": "spy"}]`     | `["spy"]`            |
| `production_companies` | `[{"name": "Marvel Studios"}]`   | `["Marvel Studios"]` |
| `production_countries` | `[{"name": "United States"}]`    | `["United States"]`  |
| `spoken_languages`     | `[{"name": "English"}]`          | `["English"]`        |

### Suppression des champs inutiles

Les champs `@timestamp`, `@version`, `event`, `host`, `log`, `message` ont été supprimés car ils sont générés par Logstash et n'ont pas de valeur analytique.

---

## 4. Problème rencontré — format de date

**Problème** : le mapping initial définissait le format `yyyy-MM-dd` mais Logstash convertit les dates en format ISO complet `2000-01-21T00:00:00.000Z` après parsing.

**Erreur** :
```
failed to parse date field [2000-01-21T00:00:00.000Z] with format [yyyy-MM-dd]
```

**Solution** : ajout des deux formats dans le mapping :
```json
"release_date": {
  "type": "date",
  "format": "yyyy-MM-dd||yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}
```

---

## 5. Analyzer personnalisé

Un analyzer `custom_text_analyzer` a été défini pour les champs texte (`title`, `overview`) :

```json
"custom_text_analyzer": {
  "type": "custom",
  "tokenizer": "standard",
  "filter": ["lowercase", "stop"]
}
```

- `standard` tokenizer → découpe en mots
- `lowercase` → met tout en minuscule
- `stop` → supprime les mots vides (the, a, is, of...)

Cela améliore la pertinence des recherches full-text sur les titres et descriptions.
