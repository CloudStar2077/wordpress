#!/bin/bash
set -e

echo "Starting WordPress Container..."

# 🔹 WordPress-Core downloaden, falls noch nicht vorhanden
if [ ! -f /var/www/html/index.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi

# 🔹 wp-config.php erstellen, falls noch nicht vorhanden
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config..."
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
fi

# 🔹 WordPress installieren, falls noch nicht installiert
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --allow-root
fi

# 🔹 Apache starten
exec apache2-foreground