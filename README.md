
<p align="center">
  <a href="https://pocketbase.io/">
    <img alt="PocketBase logo" height="128" src="https://pocketbase.io/images/logo.svg">
    <h1 align="center">Docker Image for PocketBase</h1>
  </a>
</p>

<p align="center">
   <a aria-label="Latest PocketBase Version" href="https://github.com/pocketbase/pocketbase/releases" target="_blank">
    <img alt="Latest PocketBase Version" src="https://img.shields.io/github/v/release/pocketbase/pocketbase?color=success&display_name=tag&label=latest&logo=docker&logoColor=%23fff&sort=semver&style=flat-square">
  </a>
  <a aria-label="Supported architectures" href="https://github.com/pocketbase/pocketbase/releases" target="_blank">
    <img alt="Supported Docker architectures" src="https://img.shields.io/badge/platform-amd64%20%7C%20arm64%20%7C%20armv7-brightgreen?style=flat-square&logo=linux&logoColor=%23fff">
  </a>
</p>

---

## Supported Architectures

Pulling `nxtgencat/pocketbase` will automatically retrieve the appropriate image for your system architecture.

| Architecture | Supported |
|--------------|-----------|
| amd64        | ✅        |
| arm64        | ✅        |
| armv7        | ✅        |

## Version Tags

This image offers multiple tags for different versions. Choose the appropriate tag for your use case and exercise caution when using unstable or development tags.

| Tag    | Available | Description                        |
|--------|-----------|------------------------------------|
| latest | ✅        | Latest stable release of PocketBase |
| x.x.x  | ✅        | Specific patch release             |
| x.x    | ✅        | Minor release                      |
| x      | ✅        | Major release                      |

## Application Setup

Access the web UI at `<your-ip>:8090`. For more details, refer to the [PocketBase Documentation](https://pocketbase.io/docs/).

## Usage

Below  example configurations to get started with a PocketBase container.

### Using Docker Compose (Recommended)

```yaml
version: "3.8"
services:
  pocketbase:
    image: nxtgencat/pocketbase
    container_name: pocketbase
    restart: unless-stopped
    ports:
      - "8090:8090"
    environment:
      - PB_ADMIN_EMAIL=supercat@pb.io
      - PB_ADMIN_PASSWORD=Supercat#1
      - ENCRYPTION=$(openssl rand -hex 16) # Must be 32 characters long
    volumes:
      - ./pb_data:/pb_data
      - ./pb_public:/pb_public      
      - ./pb_hooks:/pb_hooks 
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://localhost:8090/api/health || exit 1
      interval: 5s
      timeout: 5s
      retries: 5
```



## Related Repositories

- [PocketBase GitHub Repository](https://github.com/pocketbase/pocketbase)
