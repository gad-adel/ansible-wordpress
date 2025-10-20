#!/bin/bash

# Variables
BACKUP_DIR="/var/backups/mysql"  # Répertoire de sauvegarde
DB_NAME="wordpress"             # Nom de la base de données
DB_USER="root"                  # Utilisateur de la base de données
DB_PASSWORD="your_root_password" # Mot de passe de la base de données
DATE=$(date +'%Y-%m-%d_%H-%M-%S') # Date actuelle pour le nom du fichier

# Créer le répertoire de sauvegarde s'il n'existe pas
mkdir -p "$BACKUP_DIR"

# Effectuer la sauvegarde
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/db_backup_$DATE.sql"

# Vérifier si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "[$(date)] Sauvegarde réussie : $BACKUP_DIR/db_backup_$DATE.sql"
else
    echo "[$(date)] Échec de la sauvegarde" >&2
    exit 1
fi

# Supprimer les sauvegardes de plus de 7 jours
find "$BACKUP_DIR" -type f -name "db_backup_*.sql" -mtime +7 -exec rm {} \;

# Fin du script