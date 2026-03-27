# Base Image 
FROM wordpress:latest

# Set Working Directory 
WORKDIR /var/www/html

# Copy entrypoint.sh into the image and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Increase memory limit to 512M
RUN echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Install MySQL client (for WP-CLI DB checks)
RUN apt-get update && \
    apt-get install -y default-mysql-client curl && \
    rm -rf /var/lib/apt/lists/*

# Install WP CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

# Set own entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Keep WordPress default CMD
CMD ["apache2-foreground"]