# https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS158x+1T2022/block-v1:LinuxFoundationX+LFS158x+1T2022+type@sequential+block@c77b0dbe0dfe4196be4c88c2c3e43699/block-v1:LinuxFoundationX+LFS158x+1T2022+type@vertical+block@11c0ea38fdb441b2b2d55eaa0f2a4f0c

# DaemonSets

# copy the fluentd-agent.yaml to the ec2 instance
# use the scripts inside aws_scripts for this
scp -i "../aws_scripts/william-keypair.pem" fluentd-agent.yaml $user_host2:/home/ubuntu/

kubectl apply -f fluentd-agent.yaml


