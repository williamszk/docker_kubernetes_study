
# create a cluster
kind create cluster
# by default the name of the cluster is "kind"

kind get clusters

# https://youtu.be/kTp5xUtcalw?t=7452
kubectl cluster-info

# where kubectl's configuration is stored?
${HOME}/.kube/config
cat ${HOME}/.kube/config

# some kubectl configuration commands
kubectl config current-context
kubectl config get-contexts
kubectl config use-context [context_name]
kubectl config delete-context [context_name]

# Delete cluster and check if the context is still there
kind delete cluster

kind create cluster --name my-kind-cluster-01
kind create cluster --name my-kind-cluster-02
kind get clusters

kubectl config get-contexts

# ----------------------------------------------------------------------------- #
# https://youtu.be/kTp5xUtcalw?t=8092
# Example of kubectl commands, an imperative way of setting kubernetes
kubectl run mynginx --image=nginx --port=80
kubectl create deploy mynginx --image=nginx --port=80 --replicas=3
kubectl create service nodeport myservice --targetPort=8080
kubectl delete pod nginx

# ----------------------------------------------------------------------------- #
# https://youtu.be/kTp5xUtcalw?t=8350
# imperative way
kubectl create deployment mynginx1 --image=nginx

# to get the equivalent yaml from this command 
kubectl create deployment mynginx1 --image=nginx --dry-run=client -o yaml

# create the yaml for deployment and save it to a .yaml
kubectl create deployment mynginx1 --image=nginx --dry-run=client -o yaml > deploy-example-01.yaml
kubectl create -f deploy-example-01.yaml

kubectl get deployment
# NAME       READY   UP-TO-DATE   AVAILABLE   AGE
# mynginx1   1/1     1            1           15s

kubectl delete deployment mynginx1
# deployment.apps "mynginx1" deleted

# ----------------------------------------------------------------------------- #
# What is a kubernetes deployment?
# https://www.youtube.com/watch?v=tIBDjm0kzcU&ab_channel=Fabr%C3%ADcioVeronez
























