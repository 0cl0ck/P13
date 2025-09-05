# Compliance Assessment – Your Car Your Way

## Sommaire
- [Objet du document](#objet-du-document)
- [Points de contrôle](#points-de-contrôle)
  - [Composants logiciels](#composants-logiciels)
  - [Services tiers](#services-tiers)
  - [Gestion des données](#gestion-des-données)
  - [Infrastructure et déploiement](#infrastructure-et-déploiement)
  - [Sécurité](#sécurité)

---

## Objet du document
Ce document évalue la conformité de l'architecture de **Your Car Your Way** par rapport aux exigences métier, aux standards de qualité et aux contraintes réglementaires. Il est le point de convergence entre les exigences métier (`business-requirements-v2.md`) et les choix d'implémentation (`architecture-definition-document.md`).

---

## Points de contrôle

### Composants logiciels
| Point de contrôle | Statut | Justification |
|:---|:---|:---|
| **Analyse statique du code** | Validé | Utilisation d'outils d'analyse statique (type SonarLint/ESLint) pour garantir la qualité et la sécurité du code. |
| **Gestion des dépendances** | Validé | Les dépendances sont gérées via les gestionnaires de paquets (Maven/PNPM). Des audits réguliers seront menés. |
| **Tests unitaires et d'intégration** | Validé | Une couverture de code minimale de 80% est requise pour les nouvelles fonctionnalités. |

### Services tiers
| Point de contrôle | Statut | Justification |
|:---|:---|:---|
| **Fournisseur de paiement (PAY-1)** | Validé | Utilisation d'un service de paiement certifié PCI-DSS (en mode test pour la V1). Aucune donnée bancaire n'est stockée par l'application. |
| **Fournisseur d'authentification** | Prévu | L'authentification via des fournisseurs d'identité tiers (type OAuth2) est prévue mais non implémentée en V1. |

### Gestion des données
| Point de contrôle | Statut | Justification |
|:---|:---|:---|
| **Conformité RGPD (DATA-1)** | Validé | L'architecture permet la suppression et l'anonymisation des données utilisateur. Le consentement est géré. |
| **Sauvegardes** | Validé | Des sauvegardes automatiques et quotidiennes des bases de données sont configurées via les services managés du fournisseur cloud. |
| **Migration de schéma** | Validé | Utilisation d'un outil de migration de schéma (type Flyway) pour gérer les évolutions de manière versionnée et reproductible. |

### Infrastructure et déploiement
| Point de contrôle | Statut | Justification |
|:---|:---|:---|
| **Conteneurisation** | Validé | L'application et ses services sont conteneurisés (avec Docker) pour garantir la portabilité et l'isolation. |
| **Déploiement automatisé (CI/CD)** | Validé | Un pipeline CI/CD (type GitHub Actions) est configuré pour builder, tester et déployer l'application automatiquement. |
| **Monitoring et logs** | Validé | L'infrastructure est supervisée par une solution de monitoring (type Prometheus/Grafana). Les logs sont centralisés. |

### Sécurité
| Point de contrôle | Statut | Justification |
|:---|:---|:---|
| **Chiffrement des mots de passe (SEC-1)** | Validé | Les mots de passe sont hachés avec un algorithme robuste (type bcrypt). |
| **Communication sécurisée (HTTPS)** | Validé | Tout le trafic est chiffré via TLS/SSL. |
| **Gestion des secrets** | Validé | Les secrets (clés d'API, etc.) sont gérés via une solution dédiée (gestionnaire de secrets du cloud provider ou type HashiCorp Vault). |
| **Authentification API (SEC-4)** | Validé | Les endpoints de l'API sont sécurisés par des tokens (type JWT) à courte durée de vie. |
