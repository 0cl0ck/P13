# Business Requirements – Your Car Your Way

## Sommaire
- [Business Requirements – Your Car Your Way](#business-requirements--your-car-your-way)
  - [Sommaire](#sommaire)
  - [Objet du document](#objet-du-document)
  - [Contexte](#contexte)
  - [Périmètre](#périmètre)
  - [Liste des fonctionnalités](#liste-des-fonctionnalités)
    - [Gestion des utilisateurs](#gestion-des-utilisateurs)
    - [Gestion d’une location de voiture](#gestion-dune-location-de-voiture)
      - [Définition d’une offre de location](#définition-dune-offre-de-location)
  - [Exigences particulières](#exigences-particulières)

---

## Objet du document
Le document **Business Requirements** liste les fonctionnalités à implémenter pour le projet **Your Car Your Way**.  
Ces fonctionnalités sont exprimées **du point de vue métier**, sous la forme **d’actions que l’utilisateur peut effectuer sur l’application**.

---

## Contexte
**Your Car Your Way** est une entreprise de **location de voitures**.  
Actuellement, les clients utilisent **plusieurs applications web**, qui ne répondent plus :  
- Aux **besoins fonctionnels**  
- Aux **contraintes techniques**  

Une **nouvelle application centralisée** destinée à **tous les clients** doit être créée.

---

## Périmètre
Les fonctionnalités décrites dans ce document concernent **la première version** de la nouvelle application **Your Car Your Way**.  

Caractéristiques :  
- Déploiement **international**  
- Utilisation par **tous les clients de l’entreprise**  
- **Destinée uniquement aux clients** (les actions des employés en agence ne sont pas couvertes ici)

---

## Liste des fonctionnalités

> **Note de Leilani : cette section doit être complétée.**

### Gestion des utilisateurs
- Consulter son profil via la page de profil  
- Modifier ses informations personnelles (nom, prénom, date de naissance, adresse)  
- Supprimer son compte  

---

### Gestion d’une location de voiture
- Consulter la **liste des agences de location**  
- Afficher les **offres de location** après avoir rempli un formulaire de recherche incluant :  
  - Ville de départ  
  - Ville de retour  
  - Date et heure de début  
  - Date et heure de retour  
  - Catégorie du véhicule  
- Consulter le **détail d’une offre**  
- Réserver une location :  
  - Fournir ses informations personnelles (préremplies depuis le profil si disponibles)  
  - Effectuer le **paiement**  
- Consulter l’**historique des réservations** (passées et en cours)  
- **Modifier** ou **annuler** une réservation  

#### Définition d’une offre de location
Une offre est définie par :  
- Ville de départ  
- Ville de retour  
- Date et heure de départ  
- Date et heure de retour  
- Catégorie de véhicule  
- Tarif  

---

## Exigences particulières
- La **modification** d’une réservation est possible **jusqu’à 48 h** avant son début  
- **Remboursement limité à 25 %** si l’annulation a lieu **moins d’une semaine avant le début**  
- Les **catégories de véhicules** suivent la norme [ACRISS](https://www.acriss.org/car-codes/)  
- La **suppression de compte** nécessite de saisir le mot de passe  
- Les **applications agences** doivent disposer d’une **API** pour consulter et modifier les données clients, avec des **opérations CRUD standard** (utilisateur, réservation, etc.)  
- La **gestion du paiement** est externalisée via un fournisseur tiers (ex. Stripe)  
