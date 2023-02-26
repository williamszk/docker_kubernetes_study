
kubectl config view
# apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority: /home/ubuntu/.minikube/ca.crt
#     extensions:
#     - extension:
#         last-update: Tue, 21 Feb 2023 20:00:58 UTC
#         provider: minikube.sigs.k8s.io
#         version: v1.29.0
#       name: cluster_info
#     server: https://192.168.49.2:8443
#   name: minikube
# contexts:
# - context:
#     cluster: minikube
#     extensions:
#     - extension:
#         last-update: Tue, 21 Feb 2023 20:00:58 UTC
#         provider: minikube.sigs.k8s.io
#         version: v1.29.0
#       name: context_info
#     namespace: default
#     user: minikube
#   name: minikube
# current-context: minikube
# kind: Config
# preferences: {}
# users:
# - name: minikube
#   user:
#     client-certificate: /home/ubuntu/.minikube/profiles/minikube/client.crt
#     client-key: /home/ubuntu/.minikube/profiles/minikube/client.key  

cat /home/ubuntu/.minikube/ca.crt

kubectl cluster-info
# E0226 14:16:55.010070    1162 memcache.go:238] couldn't get current server API group list: Get "https://192.168.49.2:8443/api?timeout=32s": dial tcp 192.168.49.2:8443: connect: no route to host
# E0226 14:16:58.081982    1162 memcache.go:238] couldn't get current server API group list: Get "https://192.168.49.2:8443/api?timeout=32s": dial tcp 192.168.49.2:8443: connect: no route to host
# E0226 14:17:01.154050    1162 memcache.go:238] couldn't get current server API group list: Get "https://192.168.49.2:8443/api?timeout=32s": dial tcp 192.168.49.2:8443: connect: no route to host
# E0226 14:17:04.226018    1162 memcache.go:238] couldn't get current server API group list: Get "https://192.168.49.2:8443/api?timeout=32s": dial tcp 192.168.49.2:8443: connect: no route to host
# E0226 14:17:07.297995    1162 memcache.go:238] couldn't get current server API group list: Get "https://192.168.49.2:8443/api?timeout=32s": dial tcp 192.168.49.2:8443: connect: no route to host

# To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
# Unable to connect to the server: dial tcp 192.168.49.2:8443: connect: no route to host 

minikube start
# 😄  minikube v1.29.0 on Ubuntu 22.04 (xen/amd64)
# ✨  Using the docker driver based on existing profile

# 💣  Exiting due to PROVIDER_DOCKER_NEWGRP: "docker version --format -:" exit status 1: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/version": dial unix /var/run/docker.sock: connect: permission denied
# 💡  Suggestion: Add your user to the 'docker' group: 'sudo usermod -aG docker $USER && newgrp docker'
# 📘  Documentation: https://docs.docker.com/engine/install/linux-postinstall/

# I need to permanently add the solution to use docker without sudo
# https://stackoverflow.com/a/48957722/15875971
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker ps -a
# It works 👍

minikube start
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


kubectl cluster-info
# Kubernetes control plane is running at https://192.168.49.2:8443
# CoreDNS is running at https://192.168.49.2:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

# To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

ll ~/.kube/
total 16
# drwxr-xr-x 3 ubuntu ubuntu 4096 Feb 21 20:04 ./    
# drwxr-x--- 6 ubuntu ubuntu 4096 Feb 22 13:48 ../   
# drwxr-x--- 4 ubuntu ubuntu 4096 Feb 21 20:04 cache/
# -rw------- 1 ubuntu ubuntu  827 Feb 26 14:21 config

# The config file is not create automatically in other kubernetes
# But in minikube it is create automatically

cat ~/.kube/config
# apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority: /home/ubuntu/.minikube/ca.crt
#     extensions:
#     - extension:
#         last-update: Sun, 26 Feb 2023 14:21:40 UTC
#         provider: minikube.sigs.k8s.io
#         version: v1.29.0
#       name: cluster_info
#     server: https://192.168.49.2:8443
#   name: minikube
# contexts:
# - context:
#     cluster: minikube
#     extensions:
#     - extension:
#         last-update: Sun, 26 Feb 2023 14:21:40 UTC
#         provider: minikube.sigs.k8s.io
#         version: v1.29.0
#       name: context_info
#     namespace: default
#     user: minikube
#   name: minikube
# current-context: minikube
# kind: Config
# preferences: {}
# users:
# - name: minikube
#   user:
#     client-certificate: /home/ubuntu/.minikube/profiles/minikube/client.crt
#     client-key: /home/ubuntu/.minikube/profiles/minikube/client.key

# This is the same output as kubectl config view

kubectl get nodes
# NAME           STATUS   ROLES           AGE     VERSION
# minikube       Ready    control-plane   5d17h   v1.26.1
# minikube-m02   Ready    <none>          8m      v1.26.1
# minikube-m03   Ready    <none>          7m38s   v1.26.1

# With or without the s at the end the output is the same
kubectl get namespace
kubectl get namespaces
# NAME              STATUS   AGE
# default           Active   5d17h
# kube-node-lease   Active   5d17h
# kube-public       Active   5d17h
# kube-system       Active   5d17h

kubectl version
# Client Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.1", GitCommit:"8f94681cd294aa8cfd3407b8191f6c70214973a4", GitTreeState:"clean", BuildDate:"2023-01-18T15:58:16Z", GoVersion:"go1.19.5", Compiler:"gc", Platform:"linux/amd64"}
# Kustomize Version: v4.5.7
# Server Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.1", GitCommit:"8f94681cd294aa8cfd3407b8191f6c70214973a4", GitTreeState:"clean", BuildDate:"2023-01-18T15:51:25Z", GoVersion:"go1.19.5", Compiler:"gc", Platform:"linux/amd64"}

# Using Kubernetes Dashboard

# About kubectl proxy
kubectl proxy
# ubuntu@ip-172-31-23-182:~$ kubectl proxy
# Starting to serve on 127.0.0.1:8001

# This will hold the terminal
# We should run kubectl proxy as a background task

# This will start a server so that we can send http requests to the control plane
kubectl proxy &
# ubuntu@ip-172-31-23-182:~$ kubectl proxy &
# [1] 62140
# ubuntu@ip-172-31-23-182:~$ Starting to serve on 127.0.0.1:8001


# How to kill background tasks?
jobs 
kill %1

curl http://localhost:8001
# ubuntu@ip-172-31-23-182:~$ curl http://localhost:8001
# {
#   "paths": [
#     "/.well-known/openid-configuration",
#     "/api",
#     "/api/v1",
#     "/apis",
# ...

curl http://localhost:8001/api/v1
curl http://localhost:8001/apis/apps/v1
curl http://localhost:8001/healthz
# this will just send an ok
curl http://localhost:8001/metrics


# Using API with authentication
# We'll use Bearer Token
# We have this options when we don't run kubectl proxy

export TOKEN=$(kubectl create token default)

kubectl create clusterrole api-access-root \
    --verb=get --non-resource-url=/*
# clusterrole.rbac.authorization.k8s.io/api-access-root created

kubectl create clusterrolebinding api-access-root \
    --clusterrole api-access-root --serviceaccount=default:default
# clusterrolebinding.rbac.authorization.k8s.io/api-access-root created

export APISERVER=$(kubectl config view | grep https | \
    cut -f 2- -d ":" | tr -d " ")

echo $APISERVER

kubectl cluster-info

# Access API server using curl
curl $APISERVER --header "Authorization: Bearer $TOKEN" --insecure
curl $APISERVER/api/v1 --header "Authorization: Bearer $TOKEN" --insecure
curl $APISERVER/apis/apps/v1 --header "Authorization: Bearer $TOKEN" --insecure
curl $APISERVER/healthz --header "Authorization: Bearer $TOKEN" --insecure
curl $APISERVER/metrics --header "Authorization: Bearer $TOKEN" --insecure


















