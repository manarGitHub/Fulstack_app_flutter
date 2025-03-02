# shop_app

A new Flutter project.

## Getting Started

Description de l'Application
Cette application Grocery List est une application mobile développée avec Flutter permettant aux utilisateurs de gérer une liste de courses. Elle offre les fonctionnalités suivantes :

Fonctionnalités :
Affichage de la liste des courses 📋

Les éléments de la liste des courses sont récupérés depuis une base de données Firebase Realtime Database.
Chaque élément contient un nom, une quantité et une catégorie avec une couleur associée.
Ajout d'un nouvel élément ➕

Un utilisateur peut ajouter un nouvel article à la liste via un formulaire accessible depuis un écran dédié.
L’élément ajouté est enregistré en base de données et s’affiche dans la liste.
Suppression d'un élément ❌

L'utilisateur peut supprimer un élément de la liste en effectuant un glissement (swipe).
L'élément est également supprimé de la base de données.
Indicateur de chargement ⏳

Un indicateur CircularProgressIndicator s'affiche pendant le chargement des données.
Gestion des erreurs ⚠️

Si la récupération des données échoue, un message d’erreur est affiché.
Si la liste est vide, un message indiquant qu’aucun article n’a été ajouté apparaît.
Technologies utilisées :
Flutter (Framework UI)
Dart (Langage de programmation)
Firebase Realtime Database (Stockage des données)
HTTP package (Requêtes API pour récupérer les données)
Objectif de l’application
L'application permet une gestion simple et efficace des courses en synchronisant les données avec une base de données Firebase. Elle est idéale pour une utilisation personnelle ou familiale pour ne jamais oublier un article à acheter.
