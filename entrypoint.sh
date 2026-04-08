#!/bin/bash
set -e

echo "Starting WordPress Container..."

# Read Secrets 
DB_NAME=$(cat /run/secrets/db_name)
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)
WORDPRESS_URL=$(cat /run/secrets/wp_url)
ADMIN_USER=$(cat /run/secrets/wp_admin_user)
ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)

# Download WordPress core if you don't already have it.
if [ ! -f /var/www/html/index.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi  

# Create wp-config.php if it doesn't already exist.
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config..."
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
fi

# Install WordPress if it's not already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_EMAIL" \
        --allow-root
fi

exec docker-entrypoint.sh "$@"
