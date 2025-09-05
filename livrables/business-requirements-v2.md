# Business Requirements – Your Car Your Way (V2)

## Sommaire
- [Business Requirements – Your Car Your Way (V2)](#business-requirements--your-car-your-way-v2)
  - [Sommaire](#sommaire)
  - [Objet du document](#objet-du-document)
  - [Contexte du projet](#contexte-du-projet)
  - [Périmètre fonctionnel](#périmètre-fonctionnel)
  - [Vue métier et Acteurs](#vue-métier-et-acteurs)
  - [Liste des fonctionnalités (Exigences)](#liste-des-fonctionnalités-exigences)
  - [Règles métier](#règles-métier)
  - [Exigences non fonctionnelles](#exigences-non-fonctionnelles)
  - [Hypothèses et limitations](#hypothèses-et-limitations)

---

## Objet du document
Ce document (version 2) définit les exigences métier et fonctionnelles pour la V1 du produit **Your Car Your Way**. Il a pour but de cadrer le périmètre du projet et de servir de référence pour les équipes de développement et de test.

---

## Contexte du projet
L'entreprise "Your Car Your Way" souhaite moderniser son système de réservation en créant une plateforme web centralisée. L'objectif est d'améliorer l'expérience client, d'optimiser la gestion des réservations et de fournir un support client plus réactif.

---

## Périmètre fonctionnel
Le périmètre de cette version du produit (V1) inclut la gestion complète du parcours client (de l'inscription à la réservation), un système de support par tickets et chat, ainsi qu'une API pour l'intégration avec les outils internes des agences.

---

## Vue métier et Acteurs
L'application vise à fournir une plateforme unifiée pour plusieurs acteurs clés :
- **Client :** L'utilisateur final qui loue des véhicules.
- **Agent de support :** L'employé qui assiste les clients via le chat et les tickets.
- **Administrateur :** L'employé en agence qui gère les données via des outils internes (connectés par API).

**Diagramme de cas d'utilisation par acteur**
```mermaid
graph TD
    subgraph "Système Your Car Your Way"
        UC1("Gérer son compte")
        UC2("Louer un véhicule")
        UC3("Traiter les demandes support")
        UC4("Gérer les données (via API)")
    end

    Client --|> UC1
    Client --|> UC2
    AgentSupport --|> UC3
    Admin --|> UC4

    UC2 --> include("Rechercher, Réserver, Payer")
    UC3 --> include2("Gérer les tickets")
    UC3 --> include3("Répondre via le chat")

    style Client fill:#f9f,stroke:#333,stroke-width:2px
    style AgentSupport fill:#bbf,stroke:#333,stroke-width:2px
    style Admin fill:#9f9,stroke:#333,stroke-width:2px
```

---

## Liste des fonctionnalités (Exigences)
*Priorités : Must (MVP), Should (V2), Could (futur), Won't (hors périmètre)*

| ID | Exigence | Priorité | Acteur | Réf. Compliance |
|:---|:---|:---|:---|:---|
| FR-1.1 | S'inscrire avec e-mail/mot de passe | Must | Client | SEC-1, DATA-1 |
| FR-1.2 | Se connecter / Se déconnecter | Must | Client | SEC-4 |
| FR-1.3 | Consulter et modifier son profil | Must | Client | DATA-1 |
| FR-1.4 | Supprimer son compte | Must | Client | DATA-1 |
| FR-1.5 | Se connecter via un fournisseur d'identité tiers | Could | Client | - |
| FR-1.6 | Réinitialiser le mot de passe (mot de passe oublié) | Should | Client | SEC-1 |
| FR-1.7 | Vérifier l'adresse e-mail (lien de confirmation) | Could | Client | SEC-1 |
| FR-2.1 | Rechercher des offres de location | Must | Client | PERF-1 |
| FR-2.2 | Réserver un véhicule | Must | Client | PAY-1 |
| FR-2.3 | Payer via un prestataire de paiement certifié | Must | Client | PAY-1 |
| FR-2.4 | Consulter son historique de réservations | Must | Client | - |
| FR-2.5 | Modifier ou annuler une réservation | Must | Client | BR-1, BR-2 |
| FR-3.1 | Envoyer une demande (ticket) | Must | Client | - |
| FR-3.2 | Suivre le statut de ses tickets | Must | Client | - |
| Commen
| FR-3.4 | Traiter les tickets et répondre aux clients | Must | Agent Support | - |
| FR-3.5 | Démarrer une visio avec un agent (si disponible) | Could | Client | - |

---

## Règles métier
| ID | Règle | Concerne |
|:---|:---|:---|
| BR-1 | Modification de réservation | Possible sans frais **jusqu'à 48h** avant le début. |
| BR-2 | Annulation et remboursement | Remboursement intégral si > 7 jours ; **limité à 25%** si < 7 jours. |
| BR-3 | Catégories de véhicules | Doivent suivre la **norme ACRISS** (ex: `CDMR`). |
| BR-4 | API pour les agences | Une API doit permettre aux applications des agences d'effectuer des opérations **CRUD** sur les clients et réservations. |
| BR-5 | Re-auth sur opérations sensibles | Suppression de compte = re-saisie du mot de passe. |

---

## Exigences non fonctionnelles
- **Performance (PERF-1) :** Le temps de réponse pour la recherche d'offres ne doit pas excéder 3 secondes.
- **Sécurité (SEC-1, SEC-4) :** L'application doit être conforme aux standards de sécurité web (OWASP Top 10). L'authentification et la gestion des mots de passe doivent être robustes.
- **Conformité (DATA-1) :** L'application doit respecter le **RGPD**, notamment en garantissant le droit à la rectification, à l'oubli (suppression) et à la portabilité des données.
- **Disponibilité :** L'application doit viser un taux de disponibilité de 99.9%.
- **Compatibilité :** L'interface doit être responsive et compatible avec les dernières versions de Chrome, Firefox et Safari.

---

## Hypothèses et limitations
- **Périmètre V1 :** La gestion des assurances, des options de véhicule (GPS, siège bébé) et les programmes de fidélité ne sont pas inclus dans cette version.
- **Paiement :** L'intégration avec le fournisseur de paiement ne couvrira que les transactions de test.
- **Chatbot :** Le chat en V1 ne comportera pas de chatbot, seulement une mise en relation avec un agent humain.
