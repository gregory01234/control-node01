#!/bin/bash

set -euo pipefail

USER="dev01"

echo "=============================="
echo "🚀 INIT SYSTEM START"
echo "=============================="

# =========================
# UPDATE / UPGRADE
# =========================
echo ""
echo "📦 system update/upgrade..."
apt update -y
apt upgrade -y

# =========================
# USER CHECK
# =========================
echo ""
echo "👤 checking user $USER..."

if id "$USER" &>/dev/null; then
  echo "✔ user exists"
else
  echo "❌ user does not exist -> creating $USER"
  adduser --disabled-password --gecos "" "$USER"
fi

# =========================
# SUDO ACCESS
# =========================
echo ""
echo "🔐 granting sudo NOPASSWD..."

echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER
chmod 440 /etc/sudoers.d/$USER

echo "✔ sudo configured"

# =========================
# DOWNLOAD + RUN INSTALL
# =========================
echo ""
echo "🚀 downloading install.sh..."

curl -fsSL https://raw.githubusercontent.com/gregory01234/control-node01/main/install.sh -o install.sh
chmod +x install.sh

echo ""
echo "=============================="
echo "▶ STARTING INSTALL SCRIPT"
echo "=============================="

bash -x install.sh
