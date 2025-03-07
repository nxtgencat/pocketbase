<p align="center">
  <a href="https://pocketbase.io/">
    <img alt="PocketBase logo" height="128" src="https://pocketbase.io/images/logo.svg">
    <h1 align="center">PocketBase Docker</h1>
  </a>
</p>

<p align="center">
  <a aria-label="Latest Release" href="https://github.com/pocketbase/pocketbase/releases">
    <img alt="Latest PocketBase Version" src="https://img.shields.io/github/v/release/pocketbase/pocketbase?color=success&display_name=tag&label=version&logo=docker&logoColor=%23fff&sort=semver&style=for-the-badge">
  </a>
  <a aria-label="Supported Architectures" href="https://hub.docker.com/r/nxtgencat/pocketbase">
    <img alt="Docker Architectures" src="https://img.shields.io/badge/arch-amd64%20|%20arm64%20|%20armv7-blue?style=for-the-badge&logo=linux&logoColor=%23fff">
  </a>
  <a aria-label="Docker Pulls" href="https://hub.docker.com/r/nxtgencat/pocketbase">
    <img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/nxtgencat/pocketbase?style=for-the-badge&logo=docker&logoColor=%23fff">
  </a>
</p>

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
docker run -p 8090:8090 -v pb_data:/pb_data nxtgencat/pocketbase
```

Access the admin UI at http://localhost:8090/_/ after running.

## Tag Versioning

| Tag Structure | Description | Example |
|---------------|-------------|---------|
| `latest` | Latest stable release | `nxtgencat/pocketbase:latest` |
| `x.y.z` | Specific patch version | `nxtgencat/pocketbase:0.16.3` |

## Docker Compose (Recommended)

```yaml
version: "3.8"
services:
  pocketbase:
    image: nxtgencat/pocketbase:latest
    container_name: pocketbase
    restart: unless-stopped
    ports:
      - "8090:8090"
    environment:
      - PB_ADMIN_EMAIL=admin@example.com
      - PB_ADMIN_PASSWORD=SecurePassword123
      - ENCRYPTION=your32characterencryptionkeyhere
    volumes:
      - ./pb_data:/pb_data       # Database and storage
      - ./pb_public:/pb_public   # Public files
      - ./pb_hooks:/pb_hooks     # JS hooks
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://localhost:8090/api/health || exit 1
      interval: 5s
      timeout: 5s
      retries: 5
```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `PB_ADMIN_EMAIL` | Admin dashboard login email | No |
| `PB_ADMIN_PASSWORD` | Admin dashboard login password | No |
| `ENCRYPTION` | Encryption key (must be 32 chars) | No |

## Volumes

| Path | Purpose |
|------|---------|
| `/pb_data` | Database files and file storage |
| `/pb_public` | Public assets and files |
| `/pb_hooks` | JavaScript hooks for custom logic |

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
