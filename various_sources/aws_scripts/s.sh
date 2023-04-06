echo $1
if [[ $1 = start ]]
then
    stopped_instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
        python3 $PWD/aws_cli_filters.py stopped_instance_id)
    aws ec2 start-instances --instance-ids $stopped_instance_id
elif [[ $1 = stop ]]
then 
    running_instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
        python3 $PWD/aws_cli_filters.py running_instance_id)
    aws ec2 stop-instances --instance-ids $running_instance_id
elif [[ $1 = ssh ]]
then 
    public_dns=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=deleteme-test" | \
        python3 $PWD/aws_cli_filters.py public_dns)
    user="ubuntu"
    user_host="${user}@${public_dns}"
    user_host2="${user_host//[$'\t\r\n']}"
    echo $user_host2

    path_pem="./william-keypair.pem"
    ssh -i $path_pem $user_host2
fi