!#/bin/bash

aws ec2 run-instances --image-id ami-0e4e4b2f188e91845 --count 1 --instance-type t2.micro --security-group-ids sg-0ec7a1055abb5cf0c \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$1}]'


