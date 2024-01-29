#!/bin/bash
set -eu

WP_CONFIG="/srv/www/wordpress/wp-config.php"
WP_DIR="/srv/www/wordpress/"
ENV_FILE="/tmp/resources/.env"
WORDPRESS_DB_HOST=db:3306

cp "${WP_DIR}/wp-config-sample.php" "$WP_CONFIG"

if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | sed 's/#.*//g' | xargs)
fi

sed -i "s/database_name_here/${MYSQL_DATABASE}/" $WP_CONFIG
sed -i "s/username_here/${MYSQL_USER}/" $WP_CONFIG
sed -i "s/password_here/${MYSQL_PASSWORD}/" $WP_CONFIG
sed -i "s/localhost/${WORDPRESS_DB_HOST}/" $WP_CONFIG

if [ -f "$WP_CONFIG" ]; then
    sed -i '/<?php/a define('"'"'FORCE_SSL_ADMIN'"'"', true);\nif ($_SERVER['"'"'HTTP_X_FORWARDED_PROTO'"'"'] == '"'"'https'"'"')\n    $_SERVER['"'"'HTTPS'"'"']='"'"'on'"'"';\n' "$WP_CONFIG"
    echo "Konfiguracja SSL została dodana do pliku wp-config.php."
else
    echo "Plik wp-config.php nie został znaleziony."
fi

