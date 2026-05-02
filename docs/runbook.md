# Runbook — Movies ELK Platform

## Prérequis

- Docker Desktop installé et lancé
- Git installé
- Accès internet pour télécharger le dataset

---

## 1. Cloner le repo

```bash
git clone https://github.com/hlrnGH/elk_HETIC.git
cd elk_HETIC
```

## 2. Télécharger le dataset

Télécharger `tmdb_5000_movies.csv` depuis :
https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata

>**Rq** : Quand o telecharge le dataset sur Kaagle, u zip aves 2 fichiers : `tmdb_5000_credits.csv` et `tmdb_5000_movies.csv`. Il faut bien utiliser `tmdb_5000_movies.csv` pour ce projet.

Placer le fichier dans :
```bash
mkdir -p DATA/archive
cp ~/Downloads/tmdb_5000_movies.csv DATA/archive/
```

## 3. Lancer la stack

```bash
./start.sh
```
Le script attend automatiquement que tous les services soient healthy avant de rendre la main. Il affiche les URLs d'accès une fois prêt.

> Pour vérifier manuellement l'état des conteneurs :
> `docker compose ps`

## 4. Vérifier l'ingestion des données

```bash
curl "http://localhost:9200/_cat/indices?v"
```

On doit voir :
- `movies_raw` avec ~4803 documents
- `movies_clean` avec ~4802 documents

## 5. Accéder aux interfaces

| Service       | URL                   | Identifiants |
| ------------- | --------------------- | ------------ |
| Kibana        | http://localhost:5601 | aucun        |
| Elasticsearch | http://localhost:9200 | aucun        |

## 6. Arrêter la stack

```bash
./stop.sh
```

---

## Problèmes fréquents

**Les index ne sont pas créés :**
- Vérifier que le CSV est bien dans `DATA/archive/tmdb_5000_movies.csv`
- Relancer Logstash : `docker compose restart logstash`

**Conflit de noms de conteneurs :**
```bash
docker rm -f elasticsearch kibana logstash
docker compose up -d
```

**Erreur de chemin sur Mac (espaces dans le chemin) :**
- Déplacer le repo dans un chemin sans espaces : `~/elk_HETIC`