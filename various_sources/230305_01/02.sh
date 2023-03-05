
cd 230305_01/aws_scripts

scp -i $path_pem ../pods/simple-pod.yaml ${user_host2}:/home/ubuntu

# Inside the VM
kubectl apply -f simple-pod.yaml

kubectl get pods -o wide
# NAME    READY   STATUS    RESTARTS   AGE    IP           NODE           NOMINATED NODE   READINESS GATES
# nginx   1/1     Running   0          2m7s   10.244.2.2   minikube-m03   <none>           <none>

kubectl get deployments
# NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
# mongo-express        0/1     1            0           11d
# mongodb-deployment   1/1     1            1           11d

kubectl delete deployments mongo-express
kubectl delete deployments mongodb-deployment

kubectl delete pods nginx


# How to run a pod using kubectl
# (imperative way)
# kubectl run <pod_name> --image=<image_name>
kubectl run firstrun --image=nginx

# ubuntu@ip-172-31-23-182:~$ kubectl get pods
# NAME       READY   STATUS              RESTARTS   AGE
# firstrun   0/1     ContainerCreating   0          6s 

kubectl delete pods firstrun

# We can create the yaml definition using kubectl
# Then use the yaml file create to create the resource
kubectl run firstrun --image=nginx --port=80 --dry-run=client -o yaml > secondrun.yaml
# kubectl run <pod name> --image=<image name> --port=<exposed port> --dry-run=client -o yaml > <file name>.yaml
kubectl apply -f secondrun.yaml

# rm secondrun.yaml
kubectl delete pod firstrun 

# An example when the apply goes wrong
# NAME        READY   STATUS             RESTARTS   AGE
# secondrun   0/1     ImagePullBackOff   0          10s

# To check why the status is ImagePullBackOff:
kubectl describe pod secondrun
# Events:
#   Type     Reason     Age                From               Message
#   ----     ------     ----               ----               -------
#   Normal   Scheduled  88s                default-scheduler  Successfully assigned default/secondrun to minikube-m02
#   Normal   Pulling    44s (x3 over 87s)  kubelet            Pulling image "nginxx"
#   Warning  Failed     44s (x3 over 87s)  kubelet            Failed to pull image "nginxx": rpc error: code = Unknown desc = Error response from daemon: pull access denied for nginxx, repository does not exist or may require 'docker login': denied: requested access to 
# the resource is denied
#   Warning  Failed     44s (x3 over 87s)  kubelet            Error: ErrImagePull
#   Normal   BackOff    5s (x6 over 86s)   kubelet            Back-off pulling image "nginxx"
#   Warning  Failed     5s (x6 over 86s)   kubelet            Error: ImagePullBackOff

# The image name is incorrect

# Correct the typo and then run:
kubectl replace --force -f secondrun.yaml
# ubuntu@ip-172-31-23-182:~$ kubectl replace --force -f secondrun.yaml
# pod "secondrun" deleted
# pod/secondrun replaced

kubectl get pod -o wide
# NAME        READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
# secondrun   1/1     Running   0          28s   10.244.2.5   minikube-m03   <none>           <none>

# To delete we run kubectl delete against the "definition manisfest" yaml file 
kubectl delete -f secondrun.yaml



