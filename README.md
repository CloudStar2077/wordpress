# Docker Compose Setup for a Wordpress Blog-Website

Setup a multi-container `compose.yaml`, this includes the application and the database.

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

