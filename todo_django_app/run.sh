#!/bin/sh

echo "Running Migrations"
python manage.py makemigrations
python manage.py migrate
echo "Completed..."

python manage.py runserver 0.0.0.0:8000

exec "$@"
