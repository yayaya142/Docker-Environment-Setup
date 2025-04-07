# Personal Docker Dev Environment

This is a minimal Docker setup for local development with automatic cleanup and volume mounting. It is designed to be simple and beginner-friendly.

## How to Use

1. Place your project files inside the `src/` folder.
2. Open PowerShell in the root project folder (where the `.ps1` file is).
3. Run this command:

```powershell
powershell -ExecutionPolicy Bypass -File .\dev.ps1
```

This will:
- Build the Docker image using the Dockerfile
- Run a container using docker-compose
- Mount the `src/` folder as `/app` inside the container
- Set `/app` as the working directory
- Launch an interactive shell
- Automatically delete the container when you exit

## Folder Structure Explained

```
my-docker-project/
├── Dockerfile             # Defines the container environment (OS, installed packages, etc)
├── docker-compose.yml     # Manages the container setup and runtime configuration
├── dev.ps1                # PowerShell script to launch everything easily
├── README.md              # This documentation file
└── src/                   # Your working directory, mapped to the container
    └── (your files)       # Code, Makefiles, data, etc — all persist outside the container
```

- `my-docker-project/` is the root folder of the setup.
- Everything inside `src/` is shared with the container and stays on your machine.
- The container itself is temporary — it disappears when you exit.

## File Roles

### Dockerfile
Defines the base image and what is installed in the container.

```Dockerfile
FROM ubuntu
RUN apt update && apt install -y build-essential
WORKDIR /app
CMD ["/bin/bash"]
```

- `FROM ubuntu`: Use the official Ubuntu image.
- `RUN apt update && ...`: Installs basic tools like `gcc`, `make`.
- `WORKDIR /app`: Sets the default folder when container starts.
- `CMD ["/bin/bash"]`: Starts a shell session by default.

### docker-compose.yml
Defines how the container is run.

```yaml
version: '3.8'
services:
  devbox:
    build: .
    container_name: my-dev-container
    volumes:
      - ./src:/app
    working_dir: /app
    stdin_open: true
    tty: true
```

- `build: .`: Builds the image using the Dockerfile in current folder.
- `volumes`: Mounts your local `src/` as `/app` inside the container.
- `working_dir`: Sets `/app` as the shell location when container starts.
- `stdin_open`, `tty`: Enables interactive shell access.
- `--rm` (used later) ensures the container is deleted on exit.

### dev.ps1
A helper script for Windows (PowerShell) that runs everything with one command.

```powershell
Write-Host "Building image..."
docker-compose build
Write-Host "Starting container..."
docker-compose run --rm devbox
```

- First builds the image.
- Then starts the container interactively.
- Uses `--rm` so the container is cleaned up automatically.

## Using Different Base Images

You can change the OS or environment by modifying the `FROM` line in `Dockerfile`:

Examples:
```Dockerfile
FROM kalilinux/kali-rolling      # Security tools
FROM debian                      # Debian Linux base
FROM alpine                      # Minimal Linux (lightweight, advanced users)
```

After making changes, rebuild the image:
```powershell
powershell -ExecutionPolicy Bypass -File .\dev.ps1
```

## Cleanup
- No manual cleanup is required.
- The container is automatically removed when you exit the shell.
- Your files in `src/` stay untouched.

If you want to remove the built image manually:
```powershell
docker image rm my-dev-container
```

That's it. Simple and clean.

