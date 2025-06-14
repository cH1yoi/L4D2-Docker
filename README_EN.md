# L4D2 Docker Server

[English](./README.md) | [简体中文](./README.md) | [日本語](./README_JP.md)

A minimalist Left 4 Dead 2 server Docker image built on Debian 12 (Bookworm).

## Features

- Built on Debian 12 stable
- Minimal installation with essential components only
- Multi-instance deployment support
- Configurable resource allocation
- Dynamic plugin and map loading support

## Quick Start

### Pull Image

```bash
docker pull ayasehana/l4d2:latest
```

### Docker Compose Deployment

Create docker-compose.yml:

```yaml
version: "3.8"
services:
  l4d2server:
    image: ayasehana/l4d2
    container_name: "l4d2server"
    command: "-game left4dead2 -sv_lan 0 +port 27015 +sv_clockcorrection_msecs 25 -timeout 10 -tickrate 100 +map c2m1_highway"
    restart: unless-stopped
    network_mode: host
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 2G
    volumes:
      - ./maps:/maps:ro
      - ./plugins:/plugins:ro
```

Start service:

```bash
docker compose up -d
```

## Server Management

### Start Server

```bash
docker compose up -d
```

### View Logs

```bash
docker logs l4d2server
```

### Enter Container

```bash
docker exec -it l4d2server bash
```

### Stop Server

```bash
docker compose down
```

### Restart Server

```bash
docker compose restart
```

## Directory Structure

```
.
├── plugins/        # Plugins directory
└── docker-compose.yml
```

## Resource Limitations

Resource limits are configured in docker-compose.yml through deploy settings:

- CPU limit: 2 cores recommended per instance
- Memory limit: 2GB recommended per instance
- Adjustable based on actual hardware configuration

## Notes

1. Ensure server ports are not occupied
2. Proper permissions for plugins and maps
3. SSD storage recommended
4. Regular log checking for service status

## Troubleshooting

1. Server won't start

   ```bash
   # Check logs
   docker logs l4d2server
   ```
2. Can't connect to server

   ```bash
   # Check ports
   netstat -tunlp | grep 27015
   ```
3. Resource usage issues

   ```bash
   # Check resource usage
   docker stats l4d2server
   ```

## Game Update

The container includes an update script, allowing you to update the game directly without rebuilding the image:

```bash
# Enter the container
docker exec -it l4d2server bash

# Run update script
./update.sh
```

After updating, restart the container:

```bash
docker restart l4d2server
```

## License

MIT License

## Links

- [Docker Hub](https://hub.docker.com/r/ayasehana/l4d2)
- [GitHub Repository](https://github.com/cH1yoi/l4d2-docker)
