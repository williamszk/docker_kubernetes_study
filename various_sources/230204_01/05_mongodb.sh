
# permission error with docker
# dial unix /var/run/docker.sock: connect: permission denied
sudo setfacl --modify user:$USER:rw /var/run/docker.sock
docker ps -a

minikube status
minikube start

kubectl get all

# In the host machine ---------------------------------------------------------
# How to get the name of the host machine?
path_pem="william-keypair.pem"
public_dns=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | python3 $PWD/aws_cli_filters.py public_dns)
user="ubuntu"
user_host="${user}@${public_dns}"
user_host2="${user_host//[$'\t\r\n']}"
echo $user_host2

# how to send a local file to a remote machine?
scp -i $path_pem 230204_01/mongodb-deployment.yaml ${user_host2}:/home/ubuntu
scp -i $path_pem 230204_01/mongodb-secret.yaml ${user_host2}:/home/ubuntu

scp -i $path_pem 230204_01/mongo-configmap.yaml ${user_host2}:/home/ubuntu
scp -i $path_pem 230204_01/mongo-express-config.yaml ${user_host2}:/home/ubuntu
# ----------------------------------------------------------------------------

kubectl apply -f mongodb-secret.yaml
kubectl apply -f mongodb-deployment.yaml
kubectl apply -f mongo-configmap.yaml
kubectl apply -f mongo-express-config.yaml

kubectl delete -f mongodb-deployment.yaml
kubectl delete -f mongodb-secret.yaml
kubectl delete -f mongo-configmap.yaml
kubectl delete -f mongo-express-config.yaml

kubectl get deployment
kubectl get secret

kubectl get all

kubectl get pod

kubectl describe pod mongodb-deployment-5d966bd9d6-p5b2m 

kubectl get service

kubectl describe service mongodb-service

kubectl describe pod mongodb-deployment-5d966bd9d6-p5b2m
kubectl get pod -o wide

kubectl get all | grep mongodb