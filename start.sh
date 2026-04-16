#!/usr/bin/env bash
set -euo pipefail

# Constantes
readonly SERVICES=(elasticsearch kibana logstash)
readonly POLL_INTERVAL=5
readonly MAX_RETRIES=30

# Codes couleur ANSI pour l'affichage terminal
readonly GREEN='\033[0;32m'
readonly RED='\033[0;31m'
readonly YELLOW='\033[0;33m'
readonly RESET='\033[0m'

# Trois niveaux de messages : info, succès, erreur
log()  { echo -e "${YELLOW}[elk]${RESET} $*"; }
ok()   { echo -e "${GREEN}[ok]${RESET}  $*"; }
fail() { echo -e "${RED}[fail]${RESET} $*" >&2; }

# Attend qu'un conteneur Docker passe en "healthy".
# On interroge Docker toutes les POLL_INTERVAL secondes, on abandonne après MAX_RETRIES.
wait_healthy() {
  local service="$1"
  local attempt

  for attempt in $(seq 1 "$MAX_RETRIES"); do
    local status
    # docker inspect renvoie le statut du healthcheck. Si le conteneur n'existe pas
    # encore ou n'a pas de healthcheck configuré, on se rabat sur "unknown".
    status=$(docker inspect --format='{{.State.Health.Status}}' "$service" 2>/dev/null || echo "unknown")

    [[ "$status" == "healthy" ]] && { ok "$service"; return 0; }

    log "$service is $status — attempt $attempt/$MAX_RETRIES"
    sleep "$POLL_INTERVAL"
  done

  fail "$service did not become healthy after $((MAX_RETRIES * POLL_INTERVAL))s"
  return 1
}

# Démarrage de la stack en arrière-plan
log "Starting ELK stack..."
docker compose up -d

# On attend que chaque service soit prêt avant de rendre la main
log "Waiting for services to be healthy..."
for service in "${SERVICES[@]}"; do
  wait_healthy "$service"
done

# Récap des URLs d'accès
echo
ok "Stack is ready"
echo -e "  Elasticsearch : ${GREEN}http://localhost:9200${RESET}"
echo -e "  Kibana        : ${GREEN}http://localhost:5601${RESET}"
echo -e "  Logstash API  : ${GREEN}http://localhost:9600${RESET}"