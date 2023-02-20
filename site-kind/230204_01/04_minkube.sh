minikube profile list
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|
# | Profile  | VM Driver | Runtime |      IP      | Port | Version | Status  | Nodes | Active |
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|
# | minikube | docker    | docker  | 192.168.49.2 | 8443 | v1.26.1 | Running |     1 | *      |
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|

minikube stop
minikube delete

# try to create minikube cluster with 3 nodes
minikube start -n 3
# 😄  minikube v1.29.0 on Ubuntu 22.04 (xen/amd64)
# ✨  Automatically selected the docker driver. Other choices: none, ssh
# 📌  Using Docker driver with root privileges
# 👍  Starting control plane node minikube in cluster minikube
# 🚜  Pulling base image ...
# 🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
# 🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
#     ▪ Generating certificates and keys ...
#     ▪ Booting up control plane ...
#     ▪ Configuring RBAC rules ...
# 🔗  Configuring CNI (Container Networking Interface) ...
#     ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
# 🔎  Verifying Kubernetes components...
# 🌟  Enabled addons: storage-provisioner, default-storageclass

# 👍  Starting worker node minikube-m02 in cluster minikube
# 🚜  Pulling base image ...
# 🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
# 🌐  Found network options:
#     ▪ NO_PROXY=192.168.49.2
# 🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
#     ▪ env NO_PROXY=192.168.49.2
# 🔎  Verifying Kubernetes components...

# 👍  Starting worker node minikube-m03 in cluster minikube
# 🚜  Pulling base image ...
# 🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
# 🌐  Found network options:
#     ▪ NO_PROXY=192.168.49.2,192.168.49.3
# 🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
#     ▪ env NO_PROXY=192.168.49.2
#     ▪ env NO_PROXY=192.168.49.2,192.168.49.3
# 🔎  Verifying Kubernetes components...
# 🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

minikube profile list
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|
# | Profile  | VM Driver | Runtime |      IP      | Port | Version | Status  | Nodes | Active |
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|
# | minikube | docker    | docker  | 192.168.49.2 | 8443 | v1.26.1 | Running |     3 | *      |
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|

docker ps -a
# CONTAINER ID   IMAGE                                 COMMAND                  CREATED              STATUS                   PORTS                                                                                                                                  NAMES
# 38dd0ac6e260   gcr.io/k8s-minikube/kicbase:v0.0.37   "/usr/local/bin/entr…"   About a minute ago   Up About a minute        127.0.0.1:32787->22/tcp, 127.0.0.1:32786->2376/tcp, 127.0.0.1:32785->5000/tcp, 127.0.0.1:32784->8443/tcp, 127.0.0.1:32783->32443/tcp   minikube-m03     
# de070fdb30c7   gcr.io/k8s-minikube/kicbase:v0.0.37   "/usr/local/bin/entr…"   2 minutes ago        Up 2 minutes             127.0.0.1:32782->22/tcp, 127.0.0.1:32781->2376/tcp, 127.0.0.1:32780->5000/tcp, 127.0.0.1:32779->8443/tcp, 127.0.0.1:32778->32443/tcp   minikube-m02     
# 94c30ed4ddb7   gcr.io/k8s-minikube/kicbase:v0.0.37   "/usr/local/bin/entr…"   3 minutes ago        Up 3 minutes             127.0.0.1:32777->22/tcp, 127.0.0.1:32776->2376/tcp, 127.0.0.1:32775->5000/tcp, 127.0.0.1:32774->8443/tcp, 127.0.0.1:32773->32443/tcp   minikube

minikube status
# minikube
# type: Control Plane
# host: Running
# kubelet: Running
# apiserver: Running
# kubeconfig: Configured

# minikube-m02
# type: Worker
# host: Running
# kubelet: Running

# minikube-m03
# type: Worker
# host: Running
# kubelet: Running

minikube stop
# ✋  Stopping node "minikube"  ...
# 🛑  Powering off "minikube" via SSH ...
# ✋  Stopping node "minikube-m02"  ...
# 🛑  Powering off "minikube-m02" via SSH ...
# ✋  Stopping node "minikube-m03"  ...
# 🛑  Powering off "minikube-m03" via SSH ...
# 🛑  3 nodes stopped.

minikube status
# minikube
# type: Control Plane
# host: Stopped
# kubelet: Stopped
# apiserver: Stopped
# kubeconfig: Stopped

# minikube-m02
# type: Worker
# host: Stopped
# kubelet: Stopped

# minikube-m03
# type: Worker
# host: Stopped
# kubelet: Stopped

minikube profile list
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|
# | Profile  | VM Driver | Runtime |      IP      | Port | Version | Status  | Nodes | Active |
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|
# | minikube | docker    | docker  | 192.168.49.2 | 8443 | v1.26.1 | Stopped |     3 | *      |
# |----------|-----------|---------|--------------|------|---------|---------|-------|--------|

minikube start
# ubuntu@ip-172-31-23-182:~$ minikube start
# 😄  minikube v1.29.0 on Ubuntu 22.04 (xen/amd64)
# ✨  Using the docker driver based on existing profile
# 👍  Starting control plane node minikube in cluster minikube
# 🚜  Pulling base image ...
# 🔄  Restarting existing docker container for "minikube" ...
# 🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
# 🔗  Configuring CNI (Container Networking Interface) ...
# 🔎  Verifying Kubernetes components...
#     ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
# 🌟  Enabled addons: storage-provisioner, default-storageclass
# 👍  Starting worker node minikube-m02 in cluster minikube
# 🚜  Pulling base image ...
# 🔄  Restarting existing docker container for "minikube-m02" ...
# 🌐  Found network options:
#     ▪ NO_PROXY=192.168.49.2
# 🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
#     ▪ env NO_PROXY=192.168.49.2
# 🔎  Verifying Kubernetes components...
# 👍  Starting worker node minikube-m03 in cluster minikube
# 🚜  Pulling base image ...
# 🔄  Restarting existing docker container for "minikube-m03" ...
# 🌐  Found network options:
#     ▪ NO_PROXY=192.168.49.2,192.168.49.3
# 🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
#     ▪ env NO_PROXY=192.168.49.2
#     ▪ env NO_PROXY=192.168.49.2,192.168.49.3
# 🔎  Verifying Kubernetes components...
# 🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default





