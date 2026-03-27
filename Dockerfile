FROM wordpress:latest

# Arbeitsverzeichnis auf den Webserver-Root setzen
WORKDIR /var/www/html

# entrypoint.sh ins Image kopieren und ausführbar machen
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Memory Limit auf 512M erhöhen
RUN echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory-limit.ini

# MySQL-Client installieren (für WP-CLI DB-Checks)
RUN apt-get update && \
    apt-get install -y default-mysql-client curl && \
    rm -rf /var/lib/apt/lists/*

# WP-CLI installieren
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

    # eigenes entrypoint Skript setzen
ENTRYPOINT ["/entrypoint.sh"]

# Standard CMD von WordPress beibehalten
CMD ["apache2-foreground"]