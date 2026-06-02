#!/bin/bash

# --- Configuration ---
DOTFILES_REPO="git@github.com:clementtrecourt/Dot.git"
DOT_DIR="$HOME/Dot"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backups_$(date +%Y%m%d_%H%M%S)"

# Liste des dossiers/fichiers à lier (relatif à la racine de ton repo dotfiles)
# Exemple: "nvim" "fish" "tmux"
FILES_TO_LINK=("nvim" "fish" "tmux")

echo "🚀 Démarrage du bootstrap intelligent..."

# 1. Vérification de l'agent SSH
if ! ssh-add -l >/dev/null 2>&1; then
  echo "❌ Erreur: Agent SSH non détecté ou aucune clé chargée."
  echo "Assure-toi d'avoir lancé l'agent sur l'hôte et de passer SSH_AUTH_SOCK."
  exit 1
fi

# 2. Clonage du repo si inexistant
if [ ! -d "$DOT_DIR" ]; then
  echo "📥 Clonage des dotfiles depuis $DOTFILES_REPO..."
  git clone "$DOTFILES_REPO" "$DOT_DIR"
else
  echo "✅ Le dossier dotfiles existe déjà. On passe à la suite."
fi

# 3. Création du dossier de backup si nécessaire
mkdir -p "$CONFIG_DIR"

# 4. Boucle de linking intelligent
for item in "${FILES_TO_LINK[@]}"; do
  TARGET="$CONFIG_DIR/$item"
  SOURCE="$DOT_DIR/$item"

  # Vérifier si la source existe dans le repo
  if [ ! -e "$SOURCE" ]; then
    echo "⚠️  Attention: $item n'existe pas dans ton repo dotfiles. On ignore."
    continue
  fi

  # Si la cible existe déjà
  if [ -e "$TARGET" ]; then
    # Si c'est déjà un lien symbolique
    if [ -L "$TARGET" ]; then
      echo "🔗 $item est déjà un lien symbolique. On le remplace."
      rm "$TARGET"
    else
      # C'est un vrai dossier ou fichier : on backupe !
      echo "📦 Backup de l'ancien $item vers $BACKUP_DIR"
      mkdir -p "$BACKUP_DIR"
      mv "$TARGET" "$BACKUP_DIR/"
    fi
  fi

  # Création du lien symbolique
  echo "➡️  Lien créé : $item"
  ln -s "$SOURCE" "$TARGET"
done

echo "🎉 Setup terminé ! Fish et Neovim sont prêts."
