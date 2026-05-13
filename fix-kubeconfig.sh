cat > fix-kubeconfig.sh << 'EOF'
#!/bin/bash

set -e

echo "📦 Tworzę katalog kubeconfig..."
mkdir -p "$HOME/.kube"

echo "📄 Kopiuję kubeconfig z k3s..."
sudo cp /etc/rancher/k3s/k3s.yaml "$HOME/.kube/config"

echo "🔐 Ustawiam właściciela pliku..."
sudo chown $(whoami):$(whoami) "$HOME/.kube/config"

echo "🔒 Ustawiam bezpieczne uprawnienia..."
chmod 600 "$HOME/.kube/config"

echo "⚙️ Ustawiam KUBECONFIG"
export KUBECONFIG="$HOME/.kube/config"

grep -q KUBECONFIG "$HOME/.bashrc" || echo 'export KUBECONFIG=$HOME/.kube/config' >> "$HOME/.bashrc"

echo "✅ Test:"
kubectl get nodes
EOF
