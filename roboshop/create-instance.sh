#!/bin/bash


#aws ec2 run-instances --image-id ami-0e4e4b2f188e91845 --count 1 --instance-type t2.micro --security-group-ids sg-0ec7a1055abb5cf0c \
#--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$1}]'

aws ec2 request-spot-instances --spot-price "0.0036" --instance-count 1 --type "persistent" --image-id ami-0e4e4b2f188e91845 --instance-type t2.micro \
--security-group-ids sg-0ec7a1055abb5cf0c --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$1}]'

#--launch-specification file://specification.json


