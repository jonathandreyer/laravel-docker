#!/usr/bin/env bash

# Copy .env.example to .env
cp .env.example .env

# Create env
docker run --rm -v $(pwd):/app composer/composer install

# Launch docker-compose
docker-compose up -d

# Set the application key & run the optimize
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan optimize
