# Demo Script — Movies Data Platform

## Lancement du projet

Lancer la stack ELK :

docker-compose up -d

Vérifier que Elasticsearch fonctionne en allant sur :
http://localhost:9200

---

## Lancement du moteur de recherche

Lancer l’API :

node search_api.js

Si tout fonctionne, le message suivant s’affiche :
API running on http://localhost:3000

---

## Utilisation

Dans un navigateur, faire une recherche :

http://localhost:3000/search?q=batman

Ou tout autre film de votre choix.

On peut aussi ajouter un filtre de langue :

http://localhost:3000/search?q=batman&lang=en


---

## Résultat attendu

Une liste de films est retournée au format JSON avec les informations principales :
- titre
- date de sortie
- note

Cela permet de tester rapidement le fonctionnement du moteur de recherche connecté à Elasticsearch.