#!/bin/bash
set -e

PROJECT_ROOT="/home/osboxes/Documents/myproject123"
DJANGO_DIR="$PROJECT_ROOT/web"

python3 "$DJANGO_DIR/manage.py" migrate

python3 "$DJANGO_DIR/manage.py" collectstatic --noinput

