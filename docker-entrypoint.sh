#!/bin/sh
set -e

APP_DIR="/usr/src/app"
ENV_FILE="$APP_DIR/.env"

# Default Lavalink connection parameters (can be overridden by env vars)
: "${NODE_HOST:=lavalink}"
: "${NODE_PORT:=2333}"
: "${NODE_PASSWORD:=supersecret-password-here}"
: "${NODE_NAME:=main}"
: "${NODE_SECURE:=false}"

# Default bot flags
: "${PREFIX_ENABLED:=false}"
: "${ANTI_DOCKER:=true}"

echo "Creating .env file for Kenium at $ENV_FILE ..."

cat > "$ENV_FILE" <<EOF
NODE_HOST=${NODE_HOST}
NODE_PORT=${NODE_PORT}
NODE_PASSWORD=${NODE_PASSWORD}
NODE_NAME=${NODE_NAME}
NODE_SECURE=${NODE_SECURE}

token=${token}
id=${id}

PREFIX_ENABLED=${PREFIX_ENABLED}
ANTI_DOCKER=${ANTI_DOCKER}
EOF

echo ".env file created with Lavalink + Kenium settings."
echo "File output info (sanitized)"
# Also santitize output for debug, because it's more cleaner and also security
while IFS= read -r line; do
  case "$line" in
    NODE_PASSWORD=*|token=*)
      key=$(echo "$line" | cut -d'=' -f1)
      echo "$key=********"
      ;;
    *)
      echo "$line"
      ;;
  esac
done < "$ENV_FILE"

echo "Starting Kenium..."
exec "$@"
