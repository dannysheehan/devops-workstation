# Useful AWS commands to cut and paste

## get state of servers matching tag/value pair

```bash
SERVER_TAG=$1
SERVER_VALUE=$2
AWS_PROFILE=prod aws ec2 describe-instances \
    --filters "Name=tag:${SERVER_TAG},Values=${SERVER_VALUE}" \
    --query 'Reservations[].Instances[].{Id:InstanceId,Name:Tags[?Key==`Name`].Value | [0], State:State.Name, Ip:PrivateIpAddress}' \
    --output table
```

## find load balancer EC2 instances that are InService

```bash
LB_NAME=$1
aws elb describe-instance-health \
   --load-balancer-name="${LB_NAME}" \
   --query 'InstanceStates[?State==`InService`].InstanceId'
```

## register EC2 instance with ELB

```bash
aws elb register-instances-with-load-balancer \
  --load-balancer-name ${LB_NAME} \
  --instances <from_table>
```
