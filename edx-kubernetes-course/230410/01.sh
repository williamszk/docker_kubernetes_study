# https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS158x+1T2022/block-v1:LinuxFoundationX+LFS158x+1T2022+type@sequential+block@f6f8a73dc38647eeb576dce791500901/block-v1:LinuxFoundationX+LFS158x+1T2022+type@vertical+block@a6255f1b366641339fda7aed6af626f7


kubectl config view
# apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority: /home/ubuntu/.minikube/ca.crt
#     extensions:
#     - extension:
#         last-update: Mon, 10 Apr 2023 13:31:53 UTC
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
#         last-update: Mon, 10 Apr 2023 13:31:53 UTC
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


kubectl create namespace lfs158
# namespace/lfs158 created

# RBAC: Role Based Authorization Control
mkdir rbac
cd rbac

# create a new user alice
sudo useradd -s /bin/bash alice
sudo passwd alice
1234
1234

# create keys for alice
openssl genrsa -out alice.key 2048

# CSR = Certificate Signing Request

openssl req -new -key alice.key -out alice.csr -subj "/CN=alice/O=learner"
# total 16
# drwxrwxr-x 2 ubuntu ubuntu 4096 Apr 10 14:17 ./       
# drwxr-x--- 7 ubuntu ubuntu 4096 Apr 10 13:35 ../      
# -rw-rw-r-- 1 ubuntu ubuntu  911 Apr 10 14:17 alice.csr
# -rw------- 1 ubuntu ubuntu 1704 Apr 10 14:16 alice.key

cat alice.csr | base64 | tr -d '\n','%'


kubectl create -f signing-request.yaml

kubectl get csr
# NAME        AGE   SIGNERNAME                            REQUESTOR       REQUESTEDDURATION   CONDITION
# alice-csr   4s    kubernetes.io/kube-apiserver-client   minikube-user   <none>              Pending 

kubectl certificate approve alice-csr
# ubuntu@ip-172-31-23-182:~/rbac$ kubectl certificate approve alice-csr
# certificatesigningrequest.certificates.k8s.io/alice-csr approved

kubectl get csr
# NAME        AGE   SIGNERNAME                            REQUESTOR       REQUESTEDDURATION   CONDITION      
# alice-csr   58s   kubernetes.io/kube-apiserver-client   minikube-user   <none>              Approved,Issued

# create certificate from the csr certificate signing request
kubectl get csr alice-csr -o jsonpath='{.status.certificate}' | base64 > alice.crt
# drwxrwxr-x 2 ubuntu ubuntu 4096 Apr 10 14:31 ./
# drwxr-x--- 7 ubuntu ubuntu 4096 Apr 10 14:27 ../
# -rw-rw-r-- 1 ubuntu ubuntu 2039 Apr 10 14:31 alice.crt
# -rw-rw-r-- 1 ubuntu ubuntu  911 Apr 10 14:17 alice.csr
# -rw------- 1 ubuntu ubuntu 1704 Apr 10 14:16 alice.key
# -rw-r--r-- 1 ubuntu ubuntu 1483 Apr 10 14:27 signing-request.yam

cat alice.crt
# TFMwdExTMUNSVWRKVGlCRFJWSlVTVVpKUTBGVVJTMHRMUzB0Q2sxSlNVUkdla05EUVdZclowRjNT
# ...
# ...
# M0JWSzI1T2MzaEtaRlpaUTJwWGNVOVBNMVJCUW1OWFFqQXdabWhNY25KTmR6ZDVDaTB0TFMwdFJV
# NUVJRU5GVWxSSlJrbERRVlJGTFMwdExTMEs=

kubectl config set-credentials alice --client-certificate=alice.crt --client-key=alice.key
# User "alice" set.

# namespace: lfs158
# user: alice
# cluster: minikube

kubectl config set-context alice-context --cluster=minikube --namespace=lfs158 --user=alice
# Context "alice-context" created.

kubectl config view
# apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority: /home/ubuntu/.minikube/ca.crt
#     extensions:
#     - extension:
#         last-update: Mon, 10 Apr 2023 13:31:53 UTC
#         provider: minikube.sigs.k8s.io
#         version: v1.29.0
#       name: cluster_info
#     server: https://192.168.49.2:8443
#   name: minikube
# contexts:
# - context:
#     cluster: minikube
#     namespace: lfs158
#     user: alice
#   name: alice-context
# - context:
#     cluster: minikube
#     extensions:
#     - extension:
#         last-update: Mon, 10 Apr 2023 13:31:53 UTC
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
# - name: alice
#   user:
#     client-certificate: /home/ubuntu/rbac/alice.crt
#     client-key: /home/ubuntu/rbac/alice.key
# - name: minikube
#   user:
#     client-certificate: /home/ubuntu/.minikube/profiles/minikube/client.crt
#     client-key: /home/ubuntu/.minikube/profiles/minikube/client.key 

kubectl get namespace
# NAME                 STATUS   AGE
# default              Active   48d
# kube-node-lease      Active   48d
# kube-public          Active   48d
# kube-system          Active   48d
# lfs158               Active   81m
# new-namespace-name   Active   35d

kubectl -n lfs158 create deployment mynginx --image=nginx:alpine
# ubuntu@ip-172-31-23-182:~/rbac$ kubectl -n lfs158 create deployment mynginx --image=nginx:alpine
# deployment.apps/mynginx created

kubectl get deploy
kubectl -n lfs158 get deploy
# ubuntu@ip-172-31-23-182:~/rbac$ kubectl -n lfs158 get deploy
# NAME      READY   UP-TO-DATE   AVAILABLE   AGE 
# mynginx   1/1     1            1           165m

# list pods
kubectl --context=alice-context get pods
# E0410 17:45:02.086443  292607 cert_rotation.go:168] key failed with : tls: failed to find any PEM 
# data in certificate input
# E0410 17:45:02.091591  292607 cert_rotation.go:168] key failed with : tls: failed to find any PEM 
# data in certificate input
# Unable to connect to the server: tls: failed to find any PEM data in certificate input

kubectl get pods




