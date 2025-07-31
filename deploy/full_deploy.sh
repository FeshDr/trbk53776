#!/bin/bash
set -e

./install_req.sh

./setup_db.sh

./setup_django.sh

./check_nginx.sh

./gunicorn_service.sh

./nginx_config.sh
