minikube profile list

# minikube start -n 3
minikube start

# Namespaces are like "virtual sub-clusters"

# List all namespaces
kubectl get namespaces
# ubuntu@ip-172-31-23-182:~$ kubectl get namespaces
# NAME              STATUS   AGE
# default           Active   12d
# kube-node-lease   Active   12d
# kube-public       Active   12d
# kube-system       Active   12d

# Create a namespace
kubectl create namespace new-namespace-name
# ubuntu@ip-172-31-23-182:~$ kubectl create namespace new-namespace-name
# namespace/new-namespace-name created

kubectl get namespaces
# ubuntu@ip-172-31-23-182:~$ kubectl get namespaces
# NAME                 STATUS   AGE
# default              Active   12d
# kube-node-lease      Active   12d
# kube-public          Active   12d
# kube-system          Active   12d
# new-namespace-name   Active   18s





















