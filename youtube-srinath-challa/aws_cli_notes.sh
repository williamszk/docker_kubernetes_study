
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
    --image-id 'ami-06878d265978313ca' \
    --count 1 \
    --instance-type t2.micro \
    --key-name william-keypair \
    --security-group-ids sg-0839a058e5a89b2f1

# ------------------------------------------------------------------------------------------------------------------------------------------------
# List all ec2 instances  
aws ec2 describe-instances

# ------------------------------------------------------------------------------------------------------------------------------------------------
# List the instance with the specific name 'deleteme-test'
aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test"

# ------------------------------------------------------------------------------------------------------------------------------------------------
# Delete all created instances that are Running that are called 'deleteme-test'
# aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
#     python3 $PWD/aws_cli_filters.py instance_id| \
#     xargs aws ec2 terminate-instances --instance-ids 

aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
    python3 $PWD/aws_cli_filters.py instance_id | \
    aws ec2 terminate-instances --instance-ids 


# ------------------------------------------------------------------------------------------------------------------------------------------------
# How to get the name of the host machine?
path_pem="william-keypair.pem"
public_dns=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
    python3 $PWD/aws_cli_filters.py public_dns)
# I'm having a problem with this formating below because it is inserting a space
# https://stackoverflow.com/a/13662036/15875971
user_hostname=ubuntu@$public_dns
user_hostname2=$(echo $user_hostname | sed 's/ //g')

# ------------------------------------------------------------------------------------------------------------------------------------------------
# Just rebuild the release before sending the artifact up
make build-release

# ------------------------------------------------------------------------------------------------------------------------------------------------
# (optional) Maybe you'll need to change the permissions of william-keypair.pem
# chmod 400 william-keypair.pem

# ------------------------------------------------------------------------------------------------------------------------------------------------
# How to ssh into the EC2 instance?
ssh -i $path_pem $user_hostname2

