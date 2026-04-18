#!/usr/bin/env bash
set -euo pipefail

# Codes couleur ANSI pour l'affichage terminal
readonly YELLOW='\033[0;33m'
readonly GREEN='\033[0;32m'
readonly RESET='\033[0m'

# Deux niveaux de messages : info et succès
log() { echo -e "${YELLOW}[elk]${RESET} $*"; }
ok()  { echo -e "${GREEN}[ok]${RESET}  $*"; }

# Arrêt de la stack
log "Stopping ELK stack..."
docker compose down
ok "Stack stopped"