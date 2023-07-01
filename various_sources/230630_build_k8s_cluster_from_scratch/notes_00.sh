# notes based on:
# https://www.youtube.com/watch?v=_WW16Sp8-Jw&ab_channel=VirtualizationHowto


# in all the ec2 instances
#

# deactivate the swap
sudo swapoff -a
# sudo vim /etc/fstab
# we need to coment out swap
# (the file in ec2 instance is different from the video)


# with those we can add the kubernetes repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt update 

# we can install:
# kubeadm
# kubelet
# kubectl
# kubernetes

sudo apt-get install kubeadm kubelet kubectl kubernetes-cni -y
# we have a problem here...

# --------------------------------------------------------------------------

# --------------------------------------------------------------------------














