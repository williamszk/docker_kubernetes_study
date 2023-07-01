# this is a detour notes from notes_01.sh

# The problem:

# W: GPG error: https://packages.cloud.google.com/apt kubernetes-xenial InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
# E: The repository 'https://apt.kubernetes.io kubernetes-xenial InRelease' is not signed.
# N: Updating from such a repository can't be done securely, and is therefore disabled by default.
# N: See apt-secure(8) manpage for repository creation and user configuration details.

# What solved my problem:

# https://github.com/kubernetes/k8s.io/pull/4837#issuecomment-1446426585
# https://github.com/kubernetes/k8s.io/pull/4837#issuecomment-1446518409
# with those two above seems to work...
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B53DC80D13EDEF05
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
curl -L https://dl.k8s.io/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update


# -------------------------------------------------------------------------
# ---
# Maybe this will solve the problem:
# https://askubuntu.com/a/15272/1020380
# B53DC80D13EDEF05
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B53DC80D13EDEF05
sudo apt-get update
# didn't work
# ---
# let's try this one:
# https://github.com/kubernetes/release/issues/2862#issuecomment-1396965384
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update
# didn't work 

# ---
# The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B53DC80D13EDEF05
# packages.cloud.google.com/apt
# didn't work 

# ---
# https://github.com/kubernetes/k8s.io/pull/4837#issuecomment-1446426585
# https://github.com/kubernetes/k8s.io/pull/4837#issuecomment-1446518409
# with those two above seems to work...
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B53DC80D13EDEF05
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
curl -L https://dl.k8s.io/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update

# ---
# in ubuntu how to remove a gpg key from the apt repository?
# ChatGPT
sudo apt-key list
sudo apt-key del [KEY_ID]
# end
# ---

# try to remove the cloud.google.gpg
# and see if the error in apt update stops
sudo rm cloud.google.gpg
sudo rm cloud.google.gpg~
sudo apt update

# ---
sudo vim /etc/apt/sources.list.d/kubernetes.list

# ---
# Get:5 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8993 B]
# 
# To remove the specific repository "https://packages.cloud.google.com/apt 
# kubernetes-xenial InRelease [8993 B]" from apt update, you can follow these steps:
ls /etc/apt/sources.list.d/
sudo rm /etc/apt/sources.list.d/kubernetes.list
sudo apt update
# ---

# experiment
# https://stackoverflow.com/a/59267041/8782077
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# ---
# /proc/sys/net/ipv4/ip_forward contents are not set to 1
# https://stackoverflow.com/a/55532886/8782077
sudo su
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo ubuntu
