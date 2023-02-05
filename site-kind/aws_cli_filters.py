"""This script will return the instance_id of EC2 instances that are running.
"""
import sys
import json


def base_get_instance_id(state:str="running"):
    """
    state: ["running", "stopped"]
    """
    output00 = json.load(sys.stdin)
    reservations = output00["Reservations"]

    for r in reservations:
        instances = r["Instances"]
        instance = instances[0]
        state = instance["State"]["Name"]
        if state == state:
            instance_id = instance["InstanceId"]
            print(instance_id)

def get_stopped_instance_id():
    return base_get_instance_id(state="stopped")

def get_running_instance_id():
    base_get_instance_id(state="running")


def get_public_dns():
    output00 = json.load(sys.stdin)
    reservations = output00["Reservations"]

    for r in reservations:
        instances = r["Instances"]
        instance = instances[0]
        public_dns_name = instance["PublicDnsName"]
        print(public_dns_name)


def main():
    try:
        arg = sys.argv[1]
    except IndexError:
        print("Sorry, we saw that no argument was passed, you need to pass one argument to this command.")
        return

    args_dict = {
        "running_instance_id": get_running_instance_id,
        "stopped_instance_id": get_stopped_instance_id,
        "public_dns": get_public_dns,
    }

    if args_dict.get(arg) is None:
        print(f"Sorry, we couldn't find the option '{arg}'...")
        return 

    func_selected = args_dict[arg]
    func_selected()
    return


if __name__ == "__main__":
    main()
