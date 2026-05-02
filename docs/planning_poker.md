# Planning Poker — Movies Data Platform

---

## 1. Échelle utilisée

Nous utilisons une échelle de type Fibonacci pour estimer la complexité des tâches :

- 1 : très simple  
- 2 : simple  
- 3 : complexité moyenne  
- 5 : complexe  
- 8 : très complexe  
- 13 : très complexe / incertaine  

---

## 2. Backlog des features

| Feature | Description |
|---------|-------------|
| F1 | Bootstrap de la stack ELK (Docker Compose) |
| F2 | Ingestion brute des données (movies_raw) |
| F3 | Nettoyage et normalisation des données |
| F4 | Mapping et qualité des données |
| F5 | Requêtes analytiques Elasticsearch |
| F6 | Dashboard Kibana |
| F7 | Documentation du projet |
| F8 | Moteur de recherche |

---

## 3. Estimations initiales

| Feature | Estimation |
|---------|------------|
| F1 | 3 |
| F2 | 5 |
| F3 | 5 |
| F4 | 5 |
| F5 | 5 |
| F6 | 3 |
| F7 | 3 |
| F8 | 8 |

F8 = 8 car cumul de : difficultés (5) + manque de temps = incertitude  

Les estimations initiales ont été volontairement prudentes, notamment pour le moteur de recherche (F8), qui a été considéré comme une tâche complexe en raison du cumul de plusieurs aspects techniques (requêtes, filtres, intégration) ainsi qu’une incertitude quant au temps restant disponible pour sa réalisation.  

Après réalisation, cette tâche s’est révélée plus simple que prévu dans le cadre du projet, ce Après réalisation, cette tâche s’est révélée moins complexe que prévu, mais reste une fonctionnalité nécessitant plusieurs étapes (requêtes, filtres, interface).

---

## 4. Estimations finales

Après discussion en équipe, les estimations suivantes ont été retenues :

| Feature | Estimation finale |
|---------|-------------------|
| F1 | 3 |
| F2 | 3 |
| F3 | 3 |
| F4 | 5 |
| F5 | 5 |
| F6 | 3 |
| F7 | 3 |
| F8 | 5 |

---

## 5. Hypothèses

- Le dataset est globalement propre et exploitable  
- Les transformations nécessaires restent simples  
- L’environnement Docker est fonctionnel  
- Kibana permet de produire rapidement des visualisations pertinentes  
- Le moteur de recherche reste basique (fonctionnalité secondaire)  

---

## 6. Répartition des tâches

| Membre   | Responsabilités |
|----------|-----------------|
| Harold | F1 Bootstrap, F2 Ingestion brute, F8 Moteur de recherche  |
| Nassim | F3 Nettoyage & normalisation, F5 Requêtes analytiques (implémentation principale), F4 Mapping & qualité, F7 documentation avec Rodrigue, F8 Moteur de recherche  |
| Rodrigue | F5 Requêtes analytiques (pour F6 et F8) , F6 Dashboard Kibana, F7 documentation avec Nassim, F8 Moteur de recherche  |

---

## 7. Collaboration d’équipe

Bien que les tâches aient été réparties entre les membres du groupe, le travail a été réalisé de manière collaborative.

Chaque membre a également contribué et apporté son aide sur les différentes parties du projet, notamment en cas de difficulté ou pour valider certains choix techniques.

Cette organisation a permis d’assurer une meilleure compréhension globale du projet et une cohérence dans les livrables.