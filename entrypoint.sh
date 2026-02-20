#!/bin/sh
set -e

mkdir -p /pocketbase/pb_data /pocketbase/pb_public /pocketbase/pb_hooks /pocketbase/pb_migrations

if [ -n "$PB_SUPERUSER_EMAIL" ] && [ -n "$PB_SUPERUSER_PASSWORD" ]; then
    pocketbase superuser create "$PB_SUPERUSER_EMAIL" "$PB_SUPERUSER_PASSWORD" --dir=/pocketbase/pb_data || true
fi

exec pocketbase serve \
    --http=0.0.0.0:8090 \
    --dir=/pocketbase/pb_data \
    --publicDir=/pocketbase/pb_public \
    --hooksDir=/pocketbase/pb_hooks \
    --migrationsDir=/pocketbase/pb_migrations \
    ${PB_ENCRYPTION_KEY:+--encryptionEnv=PB_ENCRYPTION_KEY}
