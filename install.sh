#!/bin/bash

set -e

echo "[1] System update"
sudo apt update -y
sudo apt install -y ansible git curl

echo "[2] Cloning repo"
if [ ! -d control-node01 ]; then
  git clone https://github.com/gregory01234/control-node01.git
fi

cd control-node01

echo "[3] Running Ansible"
ansible-playbook -i "localhost," -c local ansible/site.yml
