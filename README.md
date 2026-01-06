# PocketBase Docker

![PocketBase logo](https://pocketbase.io/images/logo.svg)

[![Latest PocketBase Version](https://img.shields.io/github/v/release/pocketbase/pocketbase?color=success&display_name=tag&label=version&logo=docker&logoColor=%23fff&sort=semver&style=for-the-badge)](https://github.com/pocketbase/pocketbase/releases)
[![Docker Architectures](https://img.shields.io/badge/arch-amd64%20|%20arm64%20|%20armv7-blue?style=for-the-badge&logo=linux&logoColor=%23fff)](https://hub.docker.com/r/nxtgencat/pocketbase)
[![Docker Pulls](https://img.shields.io/docker/pulls/nxtgencat/pocketbase?style=for-the-badge&logo=docker&logoColor=%23fff)](https://hub.docker.com/r/nxtgencat/pocketbase)

## Overview

This Docker image provides a lightweight, ready-to-use [PocketBase](https://pocketbase.io/) instance that works across multiple architectures. PocketBase is an open source backend consisting of embedded database (SQLite) with realtime subscriptions, built-in auth management, convenient dashboard UI and simple REST-ish API.

## Features

- **Multi-architecture support**: amd64, arm64, and armv7
- **Small footprint**: Optimized image size for faster deployments
- **Easy configuration**: Simple setup with environment variables
- **Volume mounting**: Persistent data and custom configurations
- **Health checks**: Built-in container health monitoring

## Quick Start

```bash
docker run -d \
  --name pocketbase-app \
  --restart unless-stopped \
  -p 8090:8090 \
  -e PB_SUPERUSER_EMAIL="admin@example.com" \
  -e PB_SUPERUSER_PASSWORD="Password123!" \
  -e PB_ENCRYPTION_KEY="a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6" \
  -v pocketbase-app:/pocketbase \
  --health-cmd="curl -f http://localhost:8090/api/health" \
  --health-interval=30s \
  --health-timeout=10s \
  --health-retries=3 \
  nxtgencat/pocketbase:latest
```

Access the admin UI at <http://localhost:8090/_/> after running.

## Tag Versioning

| Tag Structure | Description | Example |
|---------------|-------------|---------|
| `latest` | Latest stable release | `nxtgencat/pocketbase:latest` |
| `x.y.z` | Specific patch version | `nxtgencat/pocketbase:0.16.3` |

## Docker Compose (Recommended)

```yaml
services:
  pocketbase:
    image: nxtgencat/pocketbase:latest
    container_name: pocketbase-app
    restart: unless-stopped
    ports:
      - "8090:8090"
    environment:
      - PB_SUPERUSER_EMAIL="admin@example.com"
      - PB_SUPERUSER_PASSWORD="Password123!"
      - PB_ENCRYPTION_KEY="a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6"
    volumes:
      - pocketbase-app:/pocketbase
    healthcheck:
      test: [ "CMD", "curl", "-f", "http://localhost:8090/api/health" ]
      interval: 30s
      timeout: 10s
      retries: 3
    
volumes:
  pocketbase-app: {}

```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `PB_SUPERUSER_EMAIL` | Admin dashboard login email | No |
| `PB_SUPERUSER_PASSWORD` | Admin dashboard login password | No |
| `PB_ENCRYPTION_KEY` | Encryption key (must be 32 chars) | No |

## Volumes

| Path | Purpose |
|------|---------|
| `/pb_data` | Database files and file storage |
| `/pb_public` | Public assets and files |
| `/pb_hooks` | JavaScript hooks for custom logic |
| `/pb_migrations` | Database migration files |

## Custom Configuration

For advanced configuration, create a `pocketbase.json` file and mount it to `/pb_data/pocketbase.json`.

## Health Checks

The container includes a built-in health check endpoint at `/api/health` that returns HTTP 200 when PocketBase is running properly.

## Resources

- [PocketBase Documentation](https://pocketbase.io/docs/)
- [Docker Hub Repository](https://hub.docker.com/r/nxtgencat/pocketbase)
- [GitHub Repository](https://github.com/pocketbase/pocketbase)

## License

This Docker image is distributed under the same license as PocketBase. See [PocketBase's license](https://github.com/pocketbase/pocketbase/blob/master/LICENSE.md) for details.