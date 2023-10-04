#!/bin/bash
set -euxo pipefail

# disable swap && keeps the swap off during reboot
# ===================================================
sudo swapoff -a
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true

# Install TTYD
# ===================================================
sudo apt-get update && sudo apt-get install libjson-c-dev libuv1-dev zlib1g-dev libwebsockets-dev curl build-essential wget git cmake -y
sudo git clone https://github.com/tsl0922/ttyd.git && cd ttyd && mkdir build && cd build
sudo cmake .. && sudo make && sudo make install && cd ../ && sudo rm -rf ttyd

# Install Docker
# ===================================================
sudo apt-get update -y
sudo apt-get install -y docker.io

# Install Kubernetes Utilities
# ===================================================
KUBE_VERSION='1.27.1-00'
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubelet="${KUBE_VERSION}" kubectl="${KUBE_VERSION}" kubeadm="${KUBE_VERSION}"

# Install GO
# ===================================================
GO_VERSION='1.21.1'
sudo wget -P /tmp "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf "/tmp/go${GO_VERSION}.linux-amd64.tar.gz"
export PATH=$PATH:/usr/local/go/bin

# Install KIND
# ===================================================
KIND_VERSION='0.20.0'
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v${KIND_VERSION}/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v${KIND_VERSION}/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create Kubernetes Cluster
# ===================================================
sudo kind create cluster