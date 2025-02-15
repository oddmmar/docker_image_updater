# Docker Update Script

## Overview

This script automates the process of checking for updates to Docker images in use within a directory structure containing `docker-compose` configurations. If an update is found for any running image, the script will stop the affected containers, pull the updated images, and restart the containers.

## Features

- Recursively searches for directories containing `.yaml` or `.lml` files.
- Identifies running images using `docker compose ps`.
- Only updates images that are actively in use.
- Stops and restarts containers when updates are detected.
- Logs script execution details in `docker_update.log`.
- Displays real-time updates in the console.

## Prerequisites

- `zsh` shell installed. (Please modify as needed)
- Docker and Docker Compose installed.
- Sufficient permissions to execute Docker commands.

## Usage

1. Save the script as `update_docker.sh`. OR excute directly from git:
    ```sh
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/oddmmar/docker_image_updater/refs/heads/main/image_update.sh)"
    zsh -c "$(wget https://raw.githubusercontent.com/oddmmar/docker_image_updater/refs/heads/main/image_update.sh)"
    ```
2. Grant execution permissions:
   ```sh
   chmod +x update_docker.sh
   ```
3. Run the script:
   ```sh
   ./update_docker.sh
   ```

## Logging

- Execution details and update events are logged in `docker_update.log`.
- Real-time updates are displayed in the console but not logged.

## Troubleshooting

- Ensure Docker is running before executing the script.
- Verify permissions to execute Docker commands.
- Check `docker_update.log` for any errors or skipped updates.

## License

This script is open-source and can be modified to suit specific requirements.
