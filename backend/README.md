# API Symfony pour Gestion de l'Emploi du Temps

Bienvenue dans l'API Symfony pour la gestion de l'emploi du temps. Cette API est développée en Symfony 6.4 et offre deux endpoints principaux pour récupérer des données sur les emplois du temps des classes.

## Configuration requise

Avant de pouvoir utiliser cette API, assurez-vous que votre environnement répond aux exigences suivantes :

- **PHP 8.1 ou version ultérieure** : Cette API nécessite au minimum PHP 8.1 pour fonctionner correctement.
- **Composer** : Vous aurez besoin de Composer pour installer les dépendances nécessaires au fonctionnement de l'API.

## Installation

Pour installer l'API et ses dépendances, suivez les étapes ci-dessous :

1. Clonez ce dépôt sur votre machine locale.
2. Naviguez vers le répertoire `/backend` dans votre terminal.
3. Exécutez la commande `composer install` pour installer toutes les dépendances nécessaires.


## Endpoints

L'API offre les endpoints suivants :

- `/api/timetable?class_param=XX` : Permet de récupérer l'emploi du temps d'une classe spécifique.
- `/api/classes` : Permet de récupérer la liste des classes disponibles.

Vous pouvez retrouver 

## Utilisation

Une fois l'API installée et configurée, vous pouvez commencer à l'utiliser en effectuant des requêtes HTTP vers les endpoints mentionnés ci-dessus. Assurez-vous de respecter les méthodes HTTP appropriées (GET, POST, etc.) pour interagir avec les données de l'API.

