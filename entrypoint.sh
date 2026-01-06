#!/bin/sh
set -e

# Create directories if needed
mkdir -p /pocketbase/pb_data /pocketbase/pb_public /pocketbase/pb_hooks /pocketbase/pb_migrations

# Build args
ARGS="serve --http=0.0.0.0:8090 --dir=/pocketbase/pb_data --publicDir=/pocketbase/pb_public --hooksDir=/pocketbase/pb_hooks --migrationsDir=/pocketbase/pb_migrations"
[ -n "$PB_ENCRYPTION_KEY" ] && ARGS="$ARGS --encryptionEnv=PB_ENCRYPTION_KEY"

# Create superuser on first run
if [ ! -f /pocketbase/.initialized ] && [ -n "$PB_SUPERUSER_EMAIL" ] && [ -n "$PB_SUPERUSER_PASSWORD" ]; then
    /pocketbase/pocketbase superuser create "$PB_SUPERUSER_EMAIL" "$PB_SUPERUSER_PASSWORD" --dir=/pocketbase/pb_data || true
    touch /pocketbase/.initialized
fi

exec /pocketbase/pocketbase $ARGS
