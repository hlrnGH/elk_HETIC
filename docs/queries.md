# Requêtes Elasticsearch — Movies Clean

## 1/ Tous les films
```json
GET movies_clean/_search
{
  "query": {
    "match_all": {}
  }
}
```
***Résultats*** : 4802 documents

---

## 2/ Films d'actions (genres)
### Filtre exact sur `genre`
```json
GET movies_clean/_search
{
  "query": {
    "term": {"genres": "Action"}
  }
}
```
***Résultats*** : 1153 documents

---

## 3/ Films Marvel Studios
### Filtre exact `champ production_companies`
```json
GET movies_clean/_search
{
  "query": {
    "term": {"production_companies": "Marvel Studios"}
  }
}
```
***Résultats*** : 13 documents

---

## 4/ Films sortis entre 2000 et 2010
### Filtre par plage de dates sur `release_date`
```json
GET movies_clean/_search
{
  "query": {
    "range": {
      "release_date": {
        "gte": "2000-01-01",
        "lte": "2010-12-31"
      }
    }
  }
}
```
***Résultats*** : 2272 documents

---

## 5/ Top 10 films les mieux notés (avec au moins 100 votes)
### Tri décroissant sur `vote_average` filtré sur les films crédibles (plus de 100 votes)
```json
GET movies_clean/_search
{
  "size": 10,
  "sort": [
    {"vote_average": {"order": "desc"}}
  ],
  "query": {
    "range": {
      "vote_count": {"gte": 100}
    }
  }
}
```
***Résultats*** : 3161 documents — Top 10 : The Shawshank Redemption (8.5), The Godfather (8.4), Fight Club (8.3)

---

# ------------- Bool ---------------

## 6/ Films d'action bien notés après 2000 (must)
### Combinaison AND : `genre` == Action AND `vote_average` >= 7 AND `release_date` >= 2000
```json
GET movies_clean/_search
{
  "query": {
    "bool": {
      "must": [
        {"term": {"genres": "Action"}},
        {"range": {"vote_average": {"gte": 7}}},
        {"range": {"release_date": {"gte": "2000-01-01"}}}
      ]
    }
  }
}
```
***Résultats*** : 109 documents

---

## 7/ Films d'action ou de comédie (should)
### Au moins un des genres doit matcher — équivalent OR
```json
GET movies_clean/_search
{
  "query": {
    "bool": {
      "should": [
        {"term": {"genres": "Action"}},
        {"term": {"genres": "Comedy"}}
      ],
      "minimum_should_match": 1
    }
  }
}
```
***Résultats*** : 2617 documents

---

## 8/ Films populaires des studios indépendants (must_not)
### Films avec `popularity` > 50 en excluant les grands studios hollywoodiens
```json
GET movies_clean/_search
{
  "query": {
    "bool": {
      "must": [
        {"range": {"popularity": {"gte": 50}}}
      ],
      "must_not": [
        {"term": {"production_companies": "Warner Bros."}},
        {"term": {"production_companies": "Universal Pictures"}},
        {"term": {"production_companies": "Paramount Pictures"}},
        {"term": {"production_companies": "Columbia Pictures"}},
        {"term": {"production_companies": "Walt Disney Pictures"}}
      ]
    }
  }
}
```
***Résultats*** : 233 documents

---

## 9/ Films Marvel Studios bien notés et populaires (filter)
### Filtre sans scoring sur les films Marvel avec `vote_average` > 7
```json
GET movies_clean/_search
{
  "query": {
    "bool": {
      "filter": [
        {"term": {"production_companies": "Marvel Studios"}},
        {"range": {"vote_average": {"gt": 7}}},
        {"range": {"popularity": {"gte": 50}}}
      ]
    }
  }
}
```
***Résultats*** : 6 documents — Guardians of the Galaxy (7.9), Captain America: The Winter Soldier (7.6)

---

## 10/ Films avec gros budget ET gros revenue après 2000
### `budget` > 100M, `revenue` > 500M, `Action` OR `Adventure`
```json
GET movies_clean/_search
{
  "query": {
    "bool": {
      "must": [
        {"range": {"budget": {"gte": 100000000}}},
        {"range": {"revenue": {"gte": 500000000}}},
        {"range": {"release_date": {"gte": "2000-01-01"}}}
      ],
      "should": [
        {"term": {"genres": "Action"}},
        {"term": {"genres": "Adventure"}}
      ],
      "minimum_should_match": 1
    }
  }
}
```
***Résultats*** : 90 documents

---

## 11/ Note moyenne par studio de production
### Agrégation avg imbriquée dans terms sur `production_companies`
```json
GET movies_clean/_search
{
  "size": 0,
  "aggs": {
    "par_studio": {
      "terms": {
        "field": "production_companies",
        "size": 10
      },
      "aggs": {
        "note_moyenne": {
          "avg": {
            "field": "vote_average"
          }
        }
      }
    }
  }
}
```

---

## 12/ Distribution des films par durée (histogram)
### Distribution par tranches de 30 minutes
```json
GET movies_clean/_search
{
  "size": 0,
  "aggs": {
    "distribution_duree": {
      "histogram": {
        "field": "runtime",
        "interval": 30,
        "min_doc_count": 1
      }
    }
  }
}
```