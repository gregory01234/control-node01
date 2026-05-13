#1. Podmień skrypt
nano fix-kubeconfig.sh

#2. Uruchom normalnie
chmod +x fix-kubeconfig.sh
./fix-kubeconfig.sh

#3. Czy kubectl działa od razu
kubectl get nodes
Powinno pokazać: 
NAME               STATUS   READY
masternodetest01   Ready
