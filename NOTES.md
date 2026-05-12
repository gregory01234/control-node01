# CONTROL NODE 01 — NOTES

Problem: podczas uruchamiania install.sh Ansible zatrzymywał się na sudo password prompt i powodował timeout.

Fix (VM / DEV ONLY): wykonano sudo visudo i dodano linię:
dev01 ALL=(ALL) NOPASSWD:ALL

Efekt: sudo nie pyta o hasło, Ansible działa bez interakcji, install.sh działa w pełni automatycznie.

Uwaga: rozwiązanie tylko do środowiska testowego / VM.

Po sklonowaniu repo należy nadać uprawnienia:
chmod +x install.sh

Uruchomienie systemu:
./install.sh

Flow systemu:
install.sh → update system → install Ansible + Git → clone repo → run Ansible playbook → bootstrap K3s + Docker

Status: automatyczna instalacja działa, system uruchamia się z jednego skryptu, gotowe do dalszego rozwoju klastra.
