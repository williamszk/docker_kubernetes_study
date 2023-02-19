

minikube status

kubectl version

# Check status of nodes
kubectl get nodes

# Check pods
kubectl get pod

# Check services
kubectl get services

# We create deployments
# And the deployment is responsible for creating the pods
kubectl create deployment <name> --image=image 

kubectl create deployment my-nginx-deployment --image=nginx

kubectl get deployment

# The replica-set is the layer below deploymnets
kubectl get replicaset
# The replicaset takes care of the replicas of the pod
# the user will only think about the deployment
# and below the deployment kubernetes will take care of

# If we want to change the image of the pods
# we will change the deployment
kubectl edit deployment my-nginx-deployment 
# this will open up a vim editor and we can change it there

# create a deployment running mongodb
kubectl create deployment my-mongo-deployment --image=mongo

# show logs from an application running in a pod
kubectl logs my-mongo-deployment-6f456b546-jr9bg

# to get more information about a pod that is not starting...
kubectl describe pod my-mongo-deployment-6f456b546-jr9bg

# to get inside a pod, and run in terminal
kubectl exec -it my-mongo-deployment-6f456b546-jr9bg bash
# from inside the pod we can take a look an run commands

# to delete a deployment
kubectl delete deployment my-mongo-deployment
kubectl delete deployment my-nginx-deployment

# how to use kubectl to deploy using a configuration file
kubectl apply -f <filename.yaml>


kubectl apply -f nginx-deployment.yaml

# How to get the name of the host machine?
path_pem="william-keypair.pem"
public_dns=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
    python3 $PWD/aws_cli_filters.py public_dns)
# I'm having a problem with this formating below because it is inserting a space
# https://stackoverflow.com/a/13662036/15875971
user="ubuntu"
user_host="${user}@${public_dns}"
user_host2="${user_host//[$'\t\r\n']}"
echo $user_host2

# how to send a local file to a remote machine?
scp -i $path_pem 230204_01/nginx-config-deployment.yaml ${user_host2}:/home/ubuntu

# apply config yaml file
kubectl apply -f nginx-config-deployment.yaml


