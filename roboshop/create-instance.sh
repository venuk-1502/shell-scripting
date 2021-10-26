#!/bin/bash

instance_count=$(aws ec2 describe-instances --filters  "Name=tag:Name,Values=$1" | jq ".Reservations[].Instances[].PrivateIpAddress" | grep -v null  | wc -l)
if [ instance_count -ne 0 ]; then
  request_id=$(aws ec2 request-spot-instances --spot-price "0.0036" --instance-count 1 --type "persistent" --launch-specification file://specification.json | jq -r ".SpotInstanceRequests[].SpotInstanceRequestId")
  echo "SPOT Instance Request Created: $request_id"
else
  echo "There is an instance already with the name: $1"
echo "Sleeping for 1 minute for instance to be created"
sleep 30

instance_id=$(aws ec2 describe-spot-instance-requests --query "SpotInstanceRequests[?SpotInstanceRequestId=='${request_id}'].InstanceId|[0]")
echo "SPOT Instance Has Been Created: $instance_id"

#ip_address=$(aws ec2 describe-instances --filters  "Name=tag:Name,Values=$1" | jq ".Reservations[].Instances[].PrivateIpAddress" | grep -v null|xargs)
#
#sed -e "s/DNS_NAME/$1.knowaws.com/" -e "s/IP_ADDRESS/${ip_address}/" change-resource-record-sets.json > /tmp/change-resource-record-sets.json
#aws route53 change-resource-record-sets --hosted-zone-id Z00216652JEVANUOGF0R3 --change-batch file:///tmp/change-resource-record-sets.json | jq

#--launch-specification file://specification.json

#--tag-specifications 'ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$1}]'