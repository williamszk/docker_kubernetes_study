# I need to install kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
kubectl get nodes
rm -rf kubectl

# we can change where the kubectl is connected to
kubectl config get-contexts

# how to install minikube?
# https://minikube.sigs.k8s.io/docs/start/
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64  

minikube start
docker ps -a
kubectl get po -A

minikube dashboard

minikube pause
minikube unpause
minikube stop
minikube delete --all

# change context of kubectl
kubectl config get-contexts
kubectl config use-context <name of context>
kubectl get nodes
kubectl get pods

# "hello-kubernetes" is the name of the service
kubectl run hello-kubernetes --image=k8s.gcr.io/echoserver:1.4 --port=8080
kubectl expose deployment hello-kubernetes --type=NodePort
kubectl get service hello-kubernetes

