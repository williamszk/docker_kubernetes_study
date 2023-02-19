
# ------------------------------------------------------------------------------------------------------------------------------------------------
# Check if aws cli is installed
aws --version

# check if the current shell is configured and authenticated to make use of aws cli
aws configure

# an example command
aws iam list-users

# ------------------------------------------------------------------------------------------------------------------------------------------------
# Create a new EC2 instance with name 'deleteme-test'
# Obs: Before running this command make sure that you are in us-east-1
# when setting in 'aws configure'
aws ec2 run-instances \
    --tag-specifications \
        'ResourceType=instance,Tags=[{Key=Name,Value=deleteme-test}]' \
    # --block-device-mappings \
    #     '{"DeviceName":"xvdh","Ebs":{"VolumeSize":15}}' \
    --image-id 'ami-06878d265978313ca' \
    --instance-type t2.medium \
    --count 1 \
    --key-name william-keypair \
    --security-group-ids sg-0839a058e5a89b2f1

# ------------------------------------------------------------------------------------------------------------------------------------------------
# List all ec2 instances  
aws ec2 describe-instances

# ------------------------------------------------------------------------------------------------------------------------------------------------
# List the instance with the specific name 'deleteme-test'
aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test"

# ------------------------------------------------------------------------------------------------------------------------------------------------
############################
# Warning DELETE INSTANCE  #
############################
# Delete all created instances that are Running that are called 'deleteme-test'
running_instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
    python3 $PWD/aws_cli_filters.py running_instance_id)
aws ec2 terminate-instances --instance-ids ${running_instance_id}
# ------------------------------------------------------------------------------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------------------------------------------------------------------------
# How to ssh into the EC2 instance?
# (optional) Maybe you'll need to change the permissions of william-keypair.pem
# chmod 400 william-keypair.pem
path_pem="william-keypair.pem"
ssh -i $path_pem $user_host2

# ------------------------------------------------------------------------------------------------------------------------------------------------
# How to stop a VM?
running_instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
    python3 $PWD/aws_cli_filters.py running_instance_id)
aws ec2 stop-instances --instance-ids $running_instance_id

# ------------------------------------------------------------------------------------------------------------------------------------------------
# How to start a VM?
stopped_instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
    python3 $PWD/aws_cli_filters.py stopped_instance_id)
aws ec2 start-instances --instance-ids $stopped_instance_id
