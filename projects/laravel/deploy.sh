#!/bin/sh
composer install --optimize-autoloader --no-dev

cp .env.example .env
sed -i '/^APP_DEBUG/c APP_DEBUG=false' .env

php artisan key:generate
php artisan config:cache
php artisan event:cache
php artisan route:cache
php artisan view:cache
