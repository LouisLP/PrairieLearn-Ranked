# Deployment

This document will walk you through the process of deploying a new instance of PrairieLearn Ranked.

## Step 1: DockerHub Account

1. Create an account on [DockerHub](https://hub.docker.com/). This will be used to store the Docker image for your instance of PrairieLearn Ranked.
2. Click your account name on the top right, and go to "Account Settings".
3. Click "Security" on the left, and then click "New Access Token". Name it whatever you like, and make sure to copy the token somewhere safe. You will need it later.

## Step 2: GitHub Secrets

Either: fork this repository, gain ownership of the repository, or create a new repository with this repository as a template.

1. Go to the "Settings" tab of your repository.
2. Click "Secrets and Variables" on the left, and then click "Actions" on the sub-menu.
3. Click on "New Repository Secret" to make 2 secrets.
4. Name the first secret `DOCKERHUB_USERNAME` and paste your DockerHub username as the value.
5. Name the second secret `DOCKERHUB_TOKEN` and paste your DockerHub access token as the value.

## Step 3: Workflows

Under the PrairieLearn-Ranked repository file structure, open `.github/workflows/main.yml` and `.github/workflows/images.yml`. These are the workflows that will be used to deploy your instance of PrairieLearn Ranked. They will automatically pull the secret variables you created in the previous step, so all you need to change is the **username** of the path.

On `main.yml` there should be 10 instances of the username `drlawrenc`. Change all of these to your DockerHub username.
On `images.yml` there should be 2 instances of the username `drlawrenc`. Change both of these to your DockerHub username.

> NOTE: this can easily be done by pressing CTRL/CMD + F and typing in `drlawrenc` to find all instances of the username, and using your IDE's "replace" function to replace all instances with your username.

## Step 4: Deploy

While accessing PrairieLearn Canary, enter the command line and type `docker ps` to see if there are any running containers. If there are, you will need to stop them by typing `docker stop <container_id>` for each container. To delete the image to force a rebuild, enter:

`docker image rm <image_name>`

Next, edit the `canary.yml` file to include the "latest" path of the PrairieLearn Ranked image from DockerHub. This is simply: `<your_username>/plr:latest`. Save the file.

Finally, to run the Docker container, enter:

`docker-compose up -f canary.yml –d`
