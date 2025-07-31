#!/bin/bash
set -eu

if ! command -v nginx &> /dev/null; then
    sudo apt update
    sudo apt install -y nginx
fi
