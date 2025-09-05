# Données – Your Car Your Way

Ce répertoire contient les scripts pour initialiser des données de démonstration.

## PostgreSQL

Fichiers
- `postgres/001_init_schema.sql` : création des tables principales (`customer`, `vehicle`, `reservation`, `support_ticket`).
- `postgres/002_seed.sql` : données de démonstration minimales.

Prérequis
- Une base existante (ex: `ycw`) et un utilisateur (ex: `ycw_user`).

Import rapide (PowerShell)
```powershell
# Variables à adapter
$PGHOST = "localhost"; $PGPORT = 5432; $PGUSER = "ycw_user"; $PGDB = "ycw"

psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDB -f "data/postgres/001_init_schema.sql";
psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDB -f "data/postgres/002_seed.sql";
```

Avec un conteneur PostgreSQL déjà lancé (ex: `postgres`)
```powershell
# Remplacez postgres par le nom du conteneur et la base
Get-Content "data/postgres/001_init_schema.sql" | docker exec -i postgres psql -U postgres -d ycw;
Get-Content "data/postgres/002_seed.sql" | docker exec -i postgres psql -U postgres -d ycw;
```

## MongoDB

Fichiers
- `mongodb/conversations.schema.json` : schéma JSON (validateur de collection, optionnel).
- `mongodb/conversations.sample.json` : conversations d’exemple (JSON array).
- `mongodb/enable_validator.js` : script mongosh pour activer le validateur.

Import minimal des exemples (sans validateur)
```powershell
mongoimport --uri "mongodb://localhost:27017" --db ycw --collection conversations --file "data/mongodb/conversations.sample.json" --jsonArray;
```

Import alternatif en EXTJSON (dates/typed numbers) – recommandé avec validateur
```powershell
mongoimport --uri "mongodb://localhost:27017" --db ycw --collection conversations --file "data/mongodb/conversations.sample.extjson.json" --jsonArray;
```

Activer le validateur (optionnel)
```powershell
mongosh --nodb --file "data/mongodb/enable_validator.js";
# Puis (si nécessaire) réimporter les exemples
mongoimport --uri "mongodb://localhost:27017" --db ycw --collection conversations --file "data/mongodb/conversations.sample.json" --jsonArray;
```

Notes
- Les chemins supposent que vous lancez les commandes à la racine du projet.
- Sous Windows/PowerShell, utilisez `;` pour chaîner les commandes.
