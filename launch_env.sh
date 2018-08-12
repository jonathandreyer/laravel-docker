#!/usr/bin/env bash

# Copy .env.example to .env
cp .env.example .env

# Build images
docker build -f app.dockerfile -t shakyshane/laravel-app .
docker build -f web.dockerfile -t shakyshane/laravel-web .

# Launch docker-compose
LE_DIR=./certs docker-compose -f docker-compose.prod.yml up -d

# Set the application key & run the optimize
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan optimize
