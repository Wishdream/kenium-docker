# Kenium Music Docker Container
This repository provides a **Docker + Portainer setup** for running [Kenium Music](https://github.com/ToddyTheNoobDud/Kenium-Music), an open-source Discord music bot. Mostly because I'm running Portainer but I made it easy to setup without it.

## Containers
This portainer setup builds and runs two containers:
| Container | Purpose |
|------------|----------|
| **kenium** | The Discord music bot itself (Node.js app). |
| **lavalink** | A lightweight Java server that handles all audio playback. |

They're setup so that they both communicate internally so no external setup needed.

## Portainer Setup
This repo includes a ready-to-use **Portainer stack**, so you can just place it in Portainer without much problems. If you need a guide, here:

### Prepare Portainer Stack
1. Go to **Portainer → Stacks → Add Stack**.
2. Change the build method to **Repository**.
3. Use `https://github.com/Wishdream/kenium-docker` as the **Repository URL**.
4. Use `portainer-compose.yml` as the **Compose path**.
5. Upload `stack.env` in the **Environment variables** section and change the variables accordingly.
6. Click **Deploy the stack**.

Your stack will start both `kenium` and `lavalink` containers.


## Non-Portainer Setup (Docker Compose)
If you prefer to run without Portainer:

```bash
# Clone this repo
git clone https://github.com/wishdream/kenium-docker.git
cd kenium-docker

# Create .env file (copy from portainer/stack.env and rename if needed)
cp stack.env .env

# Run with docker-compose
docker-compose up -d
```

## Environment Variables

| Variable | Description |
|-----------|--------------|
| `NODE_NAME` | Lavalink node name (this is not the hostname, just the name of the node). |
| `NODE_PORT` | Lavalink port (default `2333`). |
| `NODE_PASSWORD` | Lavalink server password (must match in both services). |
| `token` | Your Discord bot token. |
| `id` | Discord bot client ID. |
| `PREFIX_ENABLED` | Whether prefix commands are enabled (`true`/`false`). |
| `ANTI_DOCKER` | Enables internal anti-docker process control. |

>  `NODE_HOST` is generated automatically inside the container and do not need to be in `stack.env`.


## Continuous Image Updates
A GitHub Action (`.github/workflows/docker-build.yml`) runs every week.  
It automatically:
- Clones the latest **Kenium-Music** source from ToddyTheNoobDud’s repo.
- Builds and pushes a fresh image to **Docker Hub** (`wishdream/kenium-music:latest`).

So the stack always pulls the **newest Kenium version** automatically.

## Notes
- The Lavalink service uses port **2333** internally.  
- Both containers share the same Docker network (`kenium_net`).  
- No manual rebuild is required unless you modify this Docker setup.


## License
This repository only provides the Docker setup for Kenium-Music.

All credit for **Kenium Music** belongs to [ToddyTheNoobDud](https://github.com/ToddyTheNoobDud).

---

Maintained by [**wishdream**](https://github.com/Wishdream)
