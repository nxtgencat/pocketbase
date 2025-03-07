#!/bin/bash
set -e

# Create superuser if environment variables are set
if [ ! -z "$PB_ADMIN_EMAIL" ] && [ ! -z "$PB_ADMIN_PASSWORD" ]; then
  echo "Creating superuser with email: $PB_ADMIN_EMAIL"

  # Try to create the superuser with the same data directory
  pocketbase superuser create "$PB_ADMIN_EMAIL" "$PB_ADMIN_PASSWORD" --dir=/pb_data || {
    echo "Note: Superuser may already exist or there was an issue with creation"
  }
fi

# Start PocketBase with encryption support
echo "Starting PocketBase server with encryption..."
exec pocketbase serve --http=0.0.0.0:8090 --dir=/pb_data --publicDir=/pb_public --hooksDir=/pb_hooks --encryptionEnv ENCRYPTION
