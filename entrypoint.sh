#!/bin/sh
set -e

# Ensure data directories exist
mkdir -p pb_data pb_public pb_hooks pb_migrations

# Bootstrap superuser on first run
if [ ! -f pb_data/.initialized ] && [ -n "$PB_SUPERUSER_EMAIL" ] && [ -n "$PB_SUPERUSER_PASSWORD" ]; then
    pocketbase superuser create "$PB_SUPERUSER_EMAIL" "$PB_SUPERUSER_PASSWORD" || true
    touch pb_data/.initialized
fi

# Build serve command
CMD="serve --http=0.0.0.0:8090"
[ -n "$PB_ENCRYPTION_KEY" ] && CMD="$CMD --encryptionEnv=PB_ENCRYPTION_KEY"

exec pocketbase $CMD
