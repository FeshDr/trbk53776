#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
USER="$(logname)"
PROJECT_NAME="$(basename "$PROJECT_ROOT")"
SOCKET_PATH="/run/$PROJECT_NAME/gunicorn.sock"
STATIC_PATH="$PROJECT_ROOT/web/static"

sed -e "s|%%SOCKET_PATH%%|$SOCKET_PATH|g" \
    -e "s|%%STATIC_PATH%%|$STATIC_PATH|g" \
    "$SCRIPT_DIR/myproject_nginx.template" > "$SCRIPT_DIR/myproject_nginx.conf"

sudo cp "$SCRIPT_DIR/myproject_nginx.conf" /etc/nginx/sites-available/myproject
sudo ln -sf /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled/

sudo nginx -t

if systemctl is-active --quiet nginx; then
    sudo systemctl reload nginx
else
    sudo systemctl start nginx
fi


