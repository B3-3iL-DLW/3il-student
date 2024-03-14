# Application Flutter pour l'emploi du temps et les notes - Groupe 3iL

Ce projet est une application mobile développée en Flutter par des étudiants du Groupe 3iL. Elle
vise à fournir aux étudiants un accès facile à leur emploi du temps et à leurs notes.

## Configuration

### Environnements

L'application est configurée pour fonctionner dans deux environnements différents : développement (
dev) et production (prod). Chaque environnement utilise une API distincte.

- **Dev**: Utilise une API de développement pour tester et déboguer l'application.
- **Prod**: Utilise une API de production pour une utilisation en direct.

## Version de Flutter

Ce projet utilise Flutter version 3.19.2.

## Internationalisation (i18n)

L'application utilise la fonctionnalité de localisation (l10n) de Flutter pour supporter plusieurs
langues. N'oubliez pas de générer les fichiers de localisation en exécutant `flutter gen-l10n` avant
de construire l'application.

## Pré-requis

Avant de pousser votre code, assurez-vous de respecter les points suivants :

- Utilisez `dart format` pour formater votre code.
- Exécutez `flutter analyze` pour détecter tout problème dans votre code.
- Assurez-vous d'exécuter `flutter pub get` pour installer toutes les dépendances du projet.

### Variables d'environnement

Pour que l'application fonctionne correctement, vous devez définir les variables d'environnement
suivantes dans un fichier `.env` à la racine du projet :

- `API_URL_DEV`: URL de l'API de développement.
- `API_URL_PROD`: URL de l'API de production.

## Contributions

Les contributions des autres étudiants sont les bienvenues! N'hésitez pas à proposer des
améliorations, des corrections de bugs ou de nouvelles fonctionnalités en soumettant des pull
requests.

## Licence

Ce projet est destiné à des fins éducatives.
