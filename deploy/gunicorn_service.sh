#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
USER="$(logname)"
PROJECT_NAME="$(basename "$PROJECT_ROOT")"
VENV_PATH="$PROJECT_ROOT/.venv"
PROJECT_DIR="$PROJECT_ROOT/web"
SOCKET_PATH="/run/$PROJECT_NAME/gunicorn.sock"
WSGI_MODULE="myWeb.wsgi"


sudo mkdir -p "/run/$PROJECT_NAME"
sudo chown "$USER":www-data "/run/$PROJECT_NAME"
sudo chmod 775 "/run/$PROJECT_NAME"

sed -e "s|%%USER%%|$USER|g" \
    -e "s|%%PROJECT_DIR%%|$PROJECT_DIR|g" \
    -e "s|%%VENV_PATH%%|$VENV_PATH|g" \
    -e "s|%%SOCKET_PATH%%|$SOCKET_PATH|g" \
    -e "s|%%WSGI_MODULE%%|$WSGI_MODULE|g" \
    "$SCRIPT_DIR/gunicorn.service.template" > "$SCRIPT_DIR/gunicorn.service"

sudo cp "$SCRIPT_DIR/gunicorn.service" /etc/systemd/system/gunicorn.service
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable gunicorn
sudo systemctl restart gunicorn

