#!/bin/bash
set -e

echo "Running inside container from: $(pwd)"

if [ ! -f "/pb_data/data.db" ]; then
  echo "Setting up PocketBase for the first time..."

  if [ -n "$PB_ADMIN_EMAIL" ] && [ -n "$PB_ADMIN_PASSWORD" ]; then
    pocketbase superuser create "$PB_ADMIN_EMAIL" "$PB_ADMIN_PASSWORD" --dir=/pb_data || echo "Superuser may already exist or failed to create"
  fi
else
  echo "Existing PocketBase database found, skipping superuser creation"
fi

exec pocketbase serve --http=0.0.0.0:8090 --dir=/pb_data --publicDir=/pb_public --hooksDir=/pb_hooks --encryptionEnv PB_ENCRYPTION