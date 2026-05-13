#!/bin/bash

set -euo pipefail

USER="dev01"

echo "=============================="
echo "🚀 INIT SYSTEM START"
echo "=============================="

# =========================
# UPDATE / UPGRADE (ROOT VIA SUDO)
# =========================
echo ""
echo "📦 system update/upgrade..."

sudo apt update -y
sudo apt upgrade -y

# =========================
# USER CHECK
# =========================
echo ""
echo "👤 checking user: $USER"

if id "$USER" &>/dev/null; then
  echo "✔ user exists"
else
  echo "➕ creating user $USER"
  sudo adduser --disabled-password --gecos "" "$USER"
fi

# =========================
# SUDO ACCESS CONFIG
# =========================
echo ""
echo "🔐 granting sudo NOPASSWD..."

echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER > /dev/null
sudo chmod 440 /etc/sudoers.d/$USER

echo "✔ sudo configured"

# =========================
# DOWNLOAD + RUN INSTALL
# =========================
echo ""
echo "🚀 downloading install.sh from repo..."

curl -fsSL https://raw.githubusercontent.com/gregory01234/control-node01/main/install.sh -o install.sh

chmod +x install.sh

echo ""
echo "=============================="
echo "▶ RUNNING INSTALL"
echo "=============================="

sudo bash -x install.sh
