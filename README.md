# Docker Compose Setup for a Wordpress Blog-Website

Setup a multi-container `compose.yml`, this includes the application and the database.

# Table of Contents

1. [Prerequisites](#Prerequisites) 
2. [Quickstart](#Quickstart) 
3. [Usage](#Usage)

## PREREQUISITES

- Docker (version 20.10 or higher) installed
- Git installed

## Quickstart

QUICK START GUIDE

- Clone Repository
```bash
git clone git@github.com:CloudStar2077/wordpress.git
cd /wordpress
mv example.env .env  # rename the example.env to .env
  ```
Replace the Values in the `.env` with yours.

- Build docker image
```bash
docker compose build
```  
- Run the Container
```bash
docker compose up -d
```
Open a web browser then enter the target destination to check accessibility
```bash
<HostIP>:8080
  ```

## Usage

For this setup, an `Entrypoint.sh` is used. Its basically a shell script that runs as soon as the container starts, setting up everything for the server automatically, so we don’t have to do it manually.
This contains the Wordpress Core installation including the creation of the admin login credentials and the wp-config.php for the SQL Database.

The `Dockerfile` pulls a Wordpress base image. The WORKDIR is set to the default Wordpress directory `/var/www/html`, This ensures that all subsequent commands are executed in this path.
Then copy the `entrypoint.sh` into the image and make it executable. Because the installation of some required packages may consume additional memory, increase limit to 512 MB.
For the `entrypoint.sh` script to execute some of the commands you need to download the Wordpress CLI. Then the Entrypoint is set.
Last but not least start apache in foreground, this ensures that the web server is running and the container is not immediately terminated.

With the `docker-compose.yml` the execution of a docker container gets a lot more pleasant because long commands like this 
```bash
docker run --env-file .env \                                 # "--env-file" to pass the .env file when starting the container
-d \                                                         # "-d" for detatch mode to run container in background
-p 8025:8025 \                                               # "-p" for port mapping <HostPort>:<ContainerPort>
-v /home/docker_volume_maps/data:/app/babyshop_app/data \    # "-v" for volume mapping <HostPath>:<ContainerPath>
-v /home/docker_volume_maps/media:/app/babyshop_app/media \
--name bts-app \                                             # "--name" for naming the container
--restart unless-stopped \                                   # "--restart unless-stopped" for restarting the container after an error or crash
bts-app:latest
  ```
are not necessary. Using YAML and Compose provides significantly better structure, readability, and ease of editing.

For sensitive data there is the `.env`

A `.dockerignore` and also a `.gitignore` to ignore all the files which doesnt belong into the container or repository.

Clone the repository `git@github.com:CloudStar2077/wordpress.git`

```bash
cd wordpress
  ```
In the `examples.env` are the placeholders for the envoirement variables, replace it with yours and rename the file in .env before building and starting the containers.





