#!/usr/bin/env bash

set -e

REPO="https://github.com/gregory01234/control-node01.git"

echo "[1/6] Updating system..."
sudo apt update
sudo apt upgrade -y

echo "[2/6] Installing packages..."
sudo apt install -y \
    git \
    curl \
    ansible

echo "[3/6] Cloning repository..."

if [ ! -d "control-node01" ]; then
    git clone $REPO
fi

echo "[4/6] Entering project..."

cd control-node01

echo "[5/6] Running Ansible playbook..."

ansible-playbook ansible/site.yml -K

echo "[6/6] DONE"
echo "CONTROL NODE READY"
