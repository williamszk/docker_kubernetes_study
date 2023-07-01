


# https://pwittrock.github.io/docs/getting-started-guides/scratch/
# the client machine has kubectl?
kubectl
# this articles goes in a more theoretical path instead of a hands-on
# -----------------------------------------------------------------------------
# how to install kubectl?
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

# download the executable
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# validate the binary:
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Test to ensure the version you installed is up-to-date:
kubectl version --client

# -----------------------------------------------------------------------------
# https://www.howtogeek.com/devops/how-to-start-a-kubernetes-cluster-from-scratch-with-kubeadm-and-kubectl/

sudo apt update
sudo apt install -y \
   ca-certificates \
   curl \
   gnupg \
   lsb-release

# -- step for installing containerd
# Next add the repository’s GPG key to Apt’s keyrings directory:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y containerd.io

sudo service containerd status

# for this part I needed to run each line at a time
# but there should be a better way to do this
sudo su -
sudo containerd config default > /etc/containerd/config.toml
sudo su ubuntu
cd 
cat /etc/containerd/config.toml 

sudo vim /etc/containerd/config.toml
# change line from:
# SystemdCgroup = false
# SystemdCgroup = true

sudo service containerd restart

# -- step for Installing Kubeadm, Kubectl, and Kubelet
# The three binaries are available in an Apt repository hosted by Google Cloud. 
# First register the repository’s GPG keyring:
# sudo curl -fsSLo /etc/apt/keyrings/kubernetes.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# Next add the repository to your sources…
# echo "deb [signed-by=/etc/apt/keyrings/kubernetes.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# …and update your package list:
# sudo apt update

# --
sudo curl -fsSLo /etc/apt/keyrings/kubernetes.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update

# Got this problem:
# W: GPG error: https://packages.cloud.google.com/apt kubernetes-xenial InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
# E: The repository 'https://apt.kubernetes.io kubernetes-xenial InRelease' is not signed.
# N: Updating from such a repository can't be done securely, and is therefore disabled by default.
# N: See apt-secure(8) manpage for repository creation and user configuration details.

# Now install the packages:
# sudo apt install -y kubeadm kubectl kubelet
# --

# -- step for Installing Kubeadm, Kubectl, and Kubelet
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Disabling Swap
sudo swapoff -a
# sudo vim /etc/fstab

# how to grep
# sudo grep -r 'swap' .

# Couldn't figure out this step

# ---
# How to turn off swap in an ubuntu 23.04 EC2 instance 
# https://askubuntu.com/questions/214805/how-do-i-disable-swap
# It seems that using the swapoff will do the job...

# ---
# Loading the br_netfilter Module
sudo modprobe br_netfilter

# Make it persist after a reboot by including it in your system’s modules list:
echo br_netfilter | sudo tee /etc/modules-load.d/kubernetes.conf

# ---
# Creating Your Cluster ---
# (this is for the control plane)
# this will solve a problem with restarting kubernetes and stop an error with 
# the kubeadm init
sudo su
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo ubuntu

# this is for the control plane:
# sudo kubeadm init --pod-network-cidr=10.244.0.0/16
# I had a problem because I'm using a small EC2 instance
# kubernetes needs to use 2 cores and at least 1700MB of ram, but I'll ignore those
# problems for now
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=NumCPU --ignore-preflight-errors=Mem
# the setup can take many minutes, but the following message will appear:
# Your Kubernetes control-plane has initialized successfully!

# Preparing Your Kubeconfig File ---
# (this is for the control plane)
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Installing a Pod Networking Addon ---
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

kubectl get nodes

kubectl get pods --all-namespaces

# Interacting With Your Cluster ---

kubectl taint node ip-172-31-83-209 node-role.kubernetes.io/control-plane:NoSchedule-
# node/ip-172-31-83-209 untainted

# Now try starting a simple NGINX Pod:
kubectl run nginx --image nginx:latest

kubectl get all

# Expose it with a NodePort service:
kubectl expose pod/nginx --port 80 --type NodePort

# Find the host port that was allocated to the service:
kubectl get services

# 80:32097/TCP
# http://ec2-54-175-15-77.compute-1.amazonaws.com:32097


# --- Adding Another Node ---
# (Inside the worker node)
kubeadm join 192.168.122.229:6443 \
    --node-name node-b \
    --token <token> \
    --discovery-token-ca-cert-hash sha256:<token-ca-cert-hash>

# run this inside the control plane node to retrieve its token
kubeadm token list
# ixbab5.qupq4lyl7qda1gi
# ixbab5.qupq4lyl7qda1gi6

# Token CA Cert Hash
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'
# e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855

kubeadm join 54.175.15.77:6443 \
    --node-name node-b \
    --token ixbab5.qupq4lyl7qda1gi6 \
    --discovery-token-ca-cert-hash sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855



















