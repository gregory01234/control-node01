import time
import subprocess
import requests

from kubernetes import client, config


# =========================
# WAIT FOR K3S
# =========================

def wait_for_k3s():

    print("[1] Waiting for K3s...")

    while True:

        try:
            r = requests.get(
                "https://localhost:6443/healthz",
                verify=False,
                timeout=2
            )

            if r.status_code == 200:
                print("[OK] K3s ready")
                return

        except:
            pass

        time.sleep(3)


# =========================
# LOAD CLUSTER CONFIG
# =========================

def load_cluster():

    config.load_kube_config(
        "/etc/rancher/k3s/k3s.yaml"
    )

    print("[2] Cluster loaded")


# =========================
# DEPLOY OLLAMA
# =========================

def deploy_ollama():

    print("[3] Deploying Ollama...")

    subprocess.run([
        "kubectl",
        "apply",
        "-f",
        "k8s/ollama-deployment.yaml"
    ])

    print("[OK] Ollama deployed")


# =========================
# MONITOR CLUSTER
# =========================

def monitor_cluster():

    print("[4] Monitoring cluster...")

    v1 = client.CoreV1Api()

    while True:

        pods = v1.list_pod_for_all_namespaces()

        print(f"[INFO] Running pods: {len(pods.items)}")

        time.sleep(10)


# =========================
# MAIN
# =========================

def main():

    wait_for_k3s()

    load_cluster()

    deploy_ollama()

    monitor_cluster()


if __name__ == "__main__":
    main()
