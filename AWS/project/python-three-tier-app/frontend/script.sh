#!/bin/bash

# Variables
APP_NAME="app.py"  # Remplacez par le nom de votre fichier principal Flask
VENV_DIR="venv"    # Nom du répertoire de l'environnement virtuel
REPO_URL="https://github.com/News-Technologies-Academy/devops-path.git"
TARGET_DIR="devops-path/AWS/project/python-three-tier-app/frontend"  # Répertoire cible pour le clonage du dépôt
# clone le dépôt Git
git clone "$REPO_URL"
cd "$TARGET_DIR"
sudo apt update && sudo apt install -y python3 python3-venv

python3 -m venv "$VENV_DIR"


# Activer l'environnement virtuel
source "$VENV_DIR/bin/activate" # Pour Windows, utilisez: source "$VENV_DIR/Scripts/activate"
# Pour Linux/Mac, utilisez: source "$VENV_DIR/bin/activate"

# Installer les dépendances
if [ -f "requirements.txt" ]; then
    echo "Installation des dépendances..."
    pip install -r requirements.txt
else
    echo "Fichier requirements.txt introuvable. Assurez-vous que vos dépendances sont définies."
fi



# Lancer l'application Flask
if [ -f "$APP_NAME" ]; then
    echo "Lancement de l'application Flask..."
    export FLASK_APP="$APP_NAME"
    export FLASK_ENV=development  # Mode développement (à changer en production si nécessaire)
    flask run --host=0.0.0.0 --port=5000
else
    echo "Fichier $APP_NAME introuvable. Assurez-vous que votre application Flask existe."
    deactivate
    exit 1
fi

# Désactiver l'environnement virtuel après l'arrêt de l'application
deactivate