# Deployment with Autograders

This document will walk you through the process of deploying PrairieLearn Ranked (on PrairieLearn Canary) _with_ autograders. The deployment uses a modified version of the `canary.yml` file to ensure autograder functionality.

## Prerequisites

Before proceeding, ensure you have:
- Root access to the server (the only two should be Dr. Ramon Lawrence and Dr. Firas Moosvi).
- The `canary.yml` file.

## Configuration

### Step 1: Modify the `canary.yml` File

Modify the `canary.yml` file to include the necessary volume for Docker to communicate with the host Docker daemon. This is required for the autograders to function correctly. Here is the updated `canary.yml` configuration:

```yaml
version: '3.8' # Changed to more current version
services:
  pldev:
    container_name: plcanary
    build:
      context: .
      dockerfile: Dockerfile
    depends_on:
      - postgres
    ports:
      - "4000:3000"
    volumes:
      - /srv/pl_courses/:/pl_courses/
      - /srv/canary/config.json:/PrairieLearn/config.json
      - /srv/.ssh/:/root/.ssh/
      - /srv/ubc_logo.png:/PrairieLearn/apps/prairielearn/public/images/ubc_logo.png
      - /var/run/docker.sock:/var/run/docker.sock  # Added for Docker daemon communication
      - ${HOME}/pl_ag_jobs:/jobs  # Added for autograder jobs
    networks:
      - canarynet
    environment:
      - HOST_JOBS_DIR=${HOME}/pl_ag_jobs # Added for autograder jobs
      - NODE_ENV=production # Added for autograder jobs
    restart: unless-stopped

  postgres:
    image: postgres:15
    container_name: postgresql_plcanary
    env_file: /srv/canary/creds.env
    volumes:
      - /srv/canary/data:/var/lib/postgresql/data
    networks:
      - canarynet
    restart: unless-stopped

networks:
  canarynet:
    name: canarynet
    driver: bridge
```

> The changes from the original `canary.yml` file on the server are highlighted with comments.

### Step 2: Running the Container

Use the following commands to manage the PrairieLearn container:

- To spin down the container:

```bash
docker compose -f /srv/canary/canary.yml down
```

- To spin up the container:

```bash
docker compose -f /srv/canary/canary.yml up -d
```
