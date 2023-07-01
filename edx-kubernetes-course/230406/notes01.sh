# https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS158x+1T2022/block-v1:LinuxFoundationX+LFS158x+1T2022+type@sequential+block@c77b0dbe0dfe4196be4c88c2c3e43699/block-v1:LinuxFoundationX+LFS158x+1T2022+type@vertical+block@87965f625479450ca72d079ea72bd467


minikube status
# 🎉  minikube 1.30.1 is available! Download it: https://github.com/kubernetes/minikube/releases/tag/v1.30.1
# 💡  To disable this notice, run: 'minikube config set WantUpdateNotification false'

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

minikube start

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

kubectl create deployment mynginx --image=nginx:1.15-alpine

# show deployments, replicasets and pods, using short hands
kubectl get deploy,rs,po

# filter the get with only the objects that are labeled with app=mynginx
kubectl get deploy,rs,po -l app=mynginx

# increase the number of pod replicas in the deployment
kubectl scale deployment mynginx --replicas=3


kubectl get deploy,rs,po -l app=mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl get deploy,rs,po -l app=mynginx
# NAME                      READY   UP-TO-DATE   AVAILABLE   AGE      
# deployment.apps/mynginx   3/3     3            3           3m44s    

# NAME                               DESIRED   CURRENT   READY   AGE  
# replicaset.apps/mynginx-6d459558   3         3         3       3m44s

# NAME                         READY   STATUS    RESTARTS   AGE       
# pod/mynginx-6d459558-44479   1/1     Running   0          7s        
# pod/mynginx-6d459558-88vgn   1/1     Running   0          7s        
# pod/mynginx-6d459558-b4jth   1/1     Running   0          3m44s

# Name of the replicaset
# replicaset.apps/mynginx-6d459558

kubectl describe deploy mynginx
# Name:                   mynginx
# Namespace:              default
# CreationTimestamp:      Thu, 06 Apr 2023 15:04:20 +0000
# Labels:                 app=mynginx
# Annotations:            deployment.kubernetes.io/revision: 1
# Selector:               app=mynginx
# Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
# StrategyType:           RollingUpdate
# MinReadySeconds:        0
# RollingUpdateStrategy:  25% max unavailable, 25% max surge
# Pod Template:
#   Labels:  app=mynginx
#   Containers:
#    nginx:
#     Image:        nginx:1.15-alpine  <--------
#     Port:         <none>
#     Host Port:    <none>
#     Environment:  <none>
#     Mounts:       <none>
#   Volumes:        <none>
# Conditions:
#   Type           Status  Reason
#   ----           ------  ------
#   Progressing    True    NewReplicaSetAvailable
#   Available      True    MinimumReplicasAvailable
# OldReplicaSets:  <none>
# NewReplicaSet:   mynginx-6d459558 (3/3 replicas created)
# Events:          <none>

kubectl rollout history deploy mynginx 
# deployment.apps/mynginx 
# REVISION  CHANGE-CAUSE  
# 1         <none> 

kubectl rollout history deploy mynginx  --revision=1
# deployment.apps/mynginx with revision #1
# Pod Template:
#   Labels:       app=mynginx
#         pod-template-hash=6d459558      
#   Containers:
#    nginx:
#     Image:      nginx:1.15-alpine
#     Port:       <none>
#     Host Port:  <none>
#     Environment:        <none>   
#     Mounts:     <none>
#   Volumes:      <none>

# Rolling update
# We'll change the nginx version
kubectl set image deployment mynginx nginx=nginx:1.16-alpine
# This change the revision when we check the rollout history

# ubuntu@ip-172-31-23-182:~$ kubectl set image deployment mynginx nginx=nginx:1.16-alpine
# deployment.apps/mynginx image updated

kubectl rollout history deploy mynginx 
# deployment.apps/mynginx 
# REVISION  CHANGE-CAUSE  
# 1         <none>        
# 2         <none>        

kubectl rollout history deploy mynginx  --revision=1
# ubuntu@ip-172-31-23-182:~$ kubectl rollout history deploy mynginx  --revision=1
# deployment.apps/mynginx with revision #1
# Pod Template:
#   Labels:       app=mynginx
#         pod-template-hash=6d459558      
#   Containers:
#    nginx:
#     Image:      nginx:1.15-alpine <--- this was for 1.15
#     Port:       <none>
#     Host Port:  <none>
#     Environment:        <none>
#     Mounts:     <none>
#   Volumes:      <none>

kubectl rollout history deploy mynginx  --revision=2
# ubuntu@ip-172-31-23-182:~$ kubectl rollout history deploy mynginx  --revision=2
# deployment.apps/mynginx with revision #2
# Pod Template:
#   Labels:       app=mynginx
#         pod-template-hash=676f859b77
#   Containers:
#    nginx:
#     Image:      nginx:1.16-alpine <----- for 1.16
#     Port:       <none>
#     Host Port:  <none>
#     Environment:        <none>
#     Mounts:     <none>
#   Volumes:      <none>


kubectl get deploy,rs,po -l app=mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl get deploy,rs,po -l app=mynginx
# NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
# deployment.apps/mynginx   3/3     3            3           4h17m

# NAME                                 DESIRED   CURRENT   READY   AGE
# replicaset.apps/mynginx-676f859b77   3         3         3       5m9s  # <--- there are two replicasets...
# replicaset.apps/mynginx-6d459558     0         0         0       4h17m # they are for different rollout versions

# NAME                           READY   STATUS    RESTARTS   AGE
# pod/mynginx-676f859b77-67p6s   1/1     Running   0          5m3s
# pod/mynginx-676f859b77-s92jc   1/1     Running   0          5m9s
# pod/mynginx-676f859b77-ztvq8   1/1     Running   0          5m6s

# k8s will automatically do version changes in nginx by moving the pods from one
# replicaset to another one, we can easily rollback to a previous version
# of nginx if something goes wrong in this way, because k8s will keep the replicasets
# in version history.

# Note that replicaset with id 9b77 is associated with nginx 1.16
# and replicaset id 9558 is associated with nginx 1.15

kubectl rollout undo deployment mynginx --to-revision=1
# ubuntu@ip-172-31-23-182:~$ kubectl rollout undo deployment mynginx --to-revision=1
# deployment.apps/mynginx rolled back

kubectl rollout history deploy mynginx
# deployment.apps/mynginx 
# REVISION  CHANGE-CAUSE
# 2         <none>
# 3         <none>

# the current revision is now 3, we do not go to 1 again, it is removed and 
# a new one is put in place

kubectl rollout history deploy mynginx  --revision=3
# ubuntu@ip-172-31-23-182:~$ kubectl rollout history deploy mynginx  --revision=3
# deployment.apps/mynginx with revision #3
# Pod Template:
#   Labels:       app=mynginx
#         pod-template-hash=6d459558
#   Containers:
#    nginx:
#     Image:      nginx:1.15-alpine <---- 1.15
#     Port:       <none>
#     Host Port:  <none>
#     Environment:        <none>
#     Mounts:     <none>
#   Volumes:      <none>

kubectl describe deploy mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl describe deploy mynginx
# Name:                   mynginx
# Namespace:              default
# CreationTimestamp:      Thu, 06 Apr 2023 15:04:20 +0000
# Labels:                 app=mynginx
# Annotations:            deployment.kubernetes.io/revision: 3
# Selector:               app=mynginx
# Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
# StrategyType:           RollingUpdate
# MinReadySeconds:        0
# RollingUpdateStrategy:  25% max unavailable, 25% max surge
# Pod Template:
#   Labels:  app=mynginx
#   Containers:
#    nginx:
#     Image:        nginx:1.15-alpine
#     Port:         <none>
#     Host Port:    <none>
#     Environment:  <none>
#     Mounts:       <none>
#   Volumes:        <none>
# Conditions:
#   Type           Status  Reason
#   ----           ------  ------
#   Available      True    MinimumReplicasAvailable
#   Progressing    True    NewReplicaSetAvailable
# OldReplicaSets:  <none>
# NewReplicaSet:   mynginx-6d459558 (3/3 replicas created) <--- 558 is the current replicaset, which was the initial one
# Events:
#   Type    Reason             Age    From                   Message
#   ----    ------             ----   ----                   -------
#   Normal  ScalingReplicaSet  13m    deployment-controller  Scaled up replica set mynginx-676f859b77 to 1
#   Normal  ScalingReplicaSet  13m    deployment-controller  Scaled down replica set mynginx-6d459558 to 2 from 3
#   Normal  ScalingReplicaSet  13m    deployment-controller  Scaled up replica set mynginx-676f859b77 to 2 from 1
#   Normal  ScalingReplicaSet  13m    deployment-controller  Scaled down replica set mynginx-6d459558 to 1 from 2
#   Normal  ScalingReplicaSet  13m    deployment-controller  Scaled up replica set mynginx-676f859b77 to 3 from 2
#   Normal  ScalingReplicaSet  13m    deployment-controller  Scaled down replica set mynginx-6d459558 to 0 from 1
#   Normal  ScalingReplicaSet  2m13s  deployment-controller  Scaled up replica set mynginx-6d459558 to 1 from 0
#   Normal  ScalingReplicaSet  2m12s  deployment-controller  Scaled down replica set mynginx-676f859b77 to 2 from 3
#   Normal  ScalingReplicaSet  2m12s  deployment-controller  Scaled up replica set mynginx-6d459558 to 2 from 1
#   Normal  ScalingReplicaSet  2m11s  deployment-controller  Scaled down replica set mynginx-676f859b77 to 1 from 2
#   Normal  ScalingReplicaSet  2m11s  deployment-controller  Scaled up replica set mynginx-6d459558 to 3 from 2
#   Normal  ScalingReplicaSet  2m10s  deployment-controller  Scaled down replica set mynginx-676f859b77 to 0 from 1

kubectl get deploy,rs,po -l app=mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl get deploy,rs,po -l app=mynginx
# NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
# deployment.apps/mynginx   3/3     3            3           4h28m

# NAME                                 DESIRED   CURRENT   READY   AGE
# replicaset.apps/mynginx-676f859b77   0         0         0       15m
# replicaset.apps/mynginx-6d459558     3         3         3       4h28m # <--- this replicaset is being used now by the deployment

# NAME                         READY   STATUS    RESTARTS   AGE
# pod/mynginx-6d459558-5p6wn   1/1     Running   0          3m32s
# pod/mynginx-6d459558-h6n4j   1/1     Running   0          3m31s
# pod/mynginx-6d459558-t9vxm   1/1     Running   0          3m33s

# We can rollback to the nginx version 1.16 again
# kubectl rollout undo deployment mynginx --to-revision=2

kubectl rollout history deploy mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl rollout history deploy mynginx
# deployment.apps/mynginx 
# REVISION  CHANGE-CAUSE
# 2         <none>
# 3         <none>

kubectl rollout history deploy mynginx --revision=2
# ubuntu@ip-172-31-23-182:~$ kubectl rollout history deploy mynginx --revision=2
# deployment.apps/mynginx with revision #2
# Pod Template:
#   Labels:       app=mynginx
#         pod-template-hash=676f859b77
#   Containers:
#    nginx:
#     Image:      nginx:1.16-alpine <- this is the version that we want
#     Port:       <none>
#     Host Port:  <none>
#     Environment:        <none>
#     Mounts:     <none>
#   Volumes:      <none>

# Change the version again, by just making a "rollout undo"
kubectl rollout undo deployment mynginx --to-revision=2
# ubuntu@ip-172-31-23-182:~$ kubectl rollout undo deployment mynginx --to-revision=2
# deployment.apps/mynginx rolled back

kubectl get deploy,rs,po -l app=mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl get deploy,rs,po -l app=mynginx
# NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
# deployment.apps/mynginx   3/3     3            3           4h33m

# NAME                                 DESIRED   CURRENT   READY   AGE
# replicaset.apps/mynginx-676f859b77   3         3         3       20m <--------- this one is being used
# replicaset.apps/mynginx-6d459558     0         0         0       4h33m

# NAME                           READY   STATUS    RESTARTS   AGE
# pod/mynginx-676f859b77-j5wg6   1/1     Running   0          24s
# pod/mynginx-676f859b77-szk6x   1/1     Running   0          23s
# pod/mynginx-676f859b77-wh6hl   1/1     Running   0          26s

# b77 is the replicaset being used


kubectl rollout history deploy mynginx
# ubuntu@ip-172-31-23-182:~$ kubectl rollout history deploy mynginx
# deployment.apps/mynginx 
# REVISION  CHANGE-CAUSE
# 3         <none>
# 4         <none>

# Note that version 2 because version 4
kubectl rollout history deploy mynginx --revision=4
# ubuntu@ip-172-31-23-182:~$ kubectl rollout history deploy mynginx --revision=4
# deployment.apps/mynginx with revision #4
# Pod Template:
#   Labels:       app=mynginx
#         pod-template-hash=676f859b77
#   Containers:
#    nginx:
#     Image:      nginx:1.16-alpine
#     Port:       <none>
#     Host Port:  <none>
#     Environment:        <none>
#     Mounts:     <none>
#   Volumes:      <none>

# this is rollout is the replicaset b77 with nginx version 1.16




