# https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS158x+1T2022/block-v1:LinuxFoundationX+LFS158x+1T2022+type@sequential+block@c77b0dbe0dfe4196be4c88c2c3e43699/block-v1:LinuxFoundationX+LFS158x+1T2022+type@vertical+block@11c0ea38fdb441b2b2d55eaa0f2a4f0c

# DaemonSets

# copy the fluentd-agent.yaml to the ec2 instance
# use the scripts inside aws_scripts for this
scp -i "../aws_scripts/william-keypair.pem" fluentd-agent.yaml $user_host2:/home/ubuntu/

kubectl apply -f fluentd-agent.yaml

kubectl get daemonsets.apps
# NAME            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
# fluentd-agent   3         3         3       3            3           <none>          20h


# How pods are distributed through the nodes in the cluster?
kubectl get pods -o wide
# ubuntu@ip-172-31-23-182:~$ kubectl get pods -o wide
# NAME                       READY   STATUS    RESTARTS      AGE   IP           NODE           NOMINATED NODE   READINESS GATES
# fluentd-agent-8nhq4        1/1     Running   1 (52m ago)   20h   10.244.2.2   minikube-m03   <none>           <none>
# fluentd-agent-gtk26        1/1     Running   1 (53m ago)   20h   10.244.0.4   minikube       <none>           <none>
# fluentd-agent-qx95l        1/1     Running   1 (52m ago)   20h   10.244.1.2   minikube-m02   <none>           <none>
# mynginx-676f859b77-59ztk   1/1     Running   0             52m   10.244.1.3   minikube-m02   <none>           <none>
# mynginx-676f859b77-85wdt   1/1     Running   0             52m   10.244.1.4   minikube-m02   <none>           <none>
# mynginx-676f859b77-szk6x   1/1     Running   1 (17h ago)   21h   10.244.0.2   minikube       <none>           <none>

# We know that Deployments and DaemonSets will create pods... But is the difference between the two?


# Remove a deployment, remove mynginx deployment
kubectl get deploy
# ubuntu@ip-172-31-23-182:~$ kubectl get deploy
# NAME      READY   UP-TO-DATE   AVAILABLE   AGE
# mynginx   3/3     3            3           25h
kubectl delete deploy mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl delete deploy mynginx
# deployment.apps "mynginx" deleted

# ubuntu@ip-172-31-23-182:~$ kubectl get deploy
# No resources found in default namespace.

kubectl get pods -o wide
# ubuntu@ip-172-31-23-182:~$ kubectl get pods -o wide
# NAME                  READY   STATUS    RESTARTS      AGE   IP           NODE           NOMINATED NODE   READINESS GATES
# fluentd-agent-8nhq4   1/1     Running   1 (54m ago)   20h   10.244.2.2   minikube-m03   <none>           <none>
# fluentd-agent-gtk26   1/1     Running   1 (55m ago)   20h   10.244.0.4   minikube       <none>           <none>
# fluentd-agent-qx95l   1/1     Running   1 (55m ago)   20h   10.244.1.2   minikube-m02   <none>           <none>

# See daemon sets
kubectl get ds
# ubuntu@ip-172-31-23-182:~$ kubectl get ds
# NAME            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
# fluentd-agent   3         3         3       3            3           <none>          20h

# to list daemon sets  from all namespaces
kubectl get ds -A
# NAMESPACE     NAME            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
# default       fluentd-agent   3         3         3       3            3           <none>                   20h
# kube-system   kindnet         3         3         3       3            3           <none>                   45d
# kube-system   kube-proxy      3         3         3       3            3           kubernetes.io/os=linux   45d

# Remove the daemonset
kubectl delete daemonsets.apps fluentd-agent

kubectl get ds -A
# NAMESPACE     NAME         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
# kube-system   kindnet      3         3         3       3            3           <none>                   45d
# kube-system   kube-proxy   3         3         3       3            3           kubernetes.io/os=linux   45d

kubectl get pods
# ubuntu@ip-172-31-23-182:~$ kubectl get pods
# No resources found in default namespace.




