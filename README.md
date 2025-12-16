# myv2ray

A practical and minimalistic repository for deploying **V2Ray** using Docker.  
Includes both **server-side** and **client-side** setups, based on Docker Compose, Nginx, and a clear configuration structure.

Supports **TCP** and **WebSocket** transports.

---

## Repository Structure

```text
.
├── config/                     # V2Ray configurations (server / client)
├── docker-compose.server.yml   # Docker Compose file for the server
├── docker-compose.client.yml   # Docker Compose file for the client
├── nginx.conf                  # Nginx configuration (reverse proxy)
├── init.sh                     # Initial setup script
├── .env.example                # Environment variables example
└── README.md
```

---

## Requirements

- Docker Engine
- Docker Compose v2 (`docker compose`)
- Linux / macOS
- (for server) a domain name and TLS certificates — if TLS is used via Nginx

---

## Preparation

Clone the repository:

```bash
git clone https://github.com/mcoder33/myv2ray.git
cd myv2ray
```

Create the environment file:

```bash
cp .env.example .env
```

Edit `.env` according to your setup  
(ports, UUID, domains, and other parameters).

> The `.env` file **must not** be committed to the repository.

---

## Initialization

This step is required to generate configuration files for both client and server.

```bash
bash init.sh
```

---

## Starting the Server

```bash
docker compose -f docker-compose.server.yml up -d
```

Verification:

```bash
docker ps
docker compose -f docker-compose.server.yml logs -f
```

---

## Starting the Client

```bash
docker compose -f docker-compose.client.yml up -d
```

Client logs:

```bash
docker compose -f docker-compose.client.yml logs -f
```

---

## Configuration

### V2Ray

All main parameters are located in the `config/` directory:
- protocols
- UUID / keys
- inbound / outbound
- routing
- WebSocket / TCP / TLS

Server and client configurations **must strictly match each other**.

---

### Nginx

The `nginx.conf` file is used as a reverse proxy:
- WebSocket proxying
- TLS termination
- traffic forwarding to V2Ray

---

## Updating

```bash
git pull
docker compose -f docker-compose.server.yml up -d --force-recreate
docker compose -f docker-compose.client.yml up -d --force-recreate
```

---

## Troubleshooting

If the connection does not work, check:
1. Ports and firewall rules
2. UUID and paths
3. Nginx configuration
4. DNS resolution
5. Container logs

---

## License

No license specified.
