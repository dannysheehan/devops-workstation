SERVER_ROLE=$1
AWS_PROFILE=prod aws ec2 describe-instances \
    --filters "Name=tag:Role,Values=${SERVER_ROLE}" \
    --query 'Reservations[].Instances[].{Id:InstanceId,Name:Tags[?Key==`Name`].Value | [0], State:State.Name, Ip:PrivateIpAddress}' \
    --output table


#
# find current LB instances that are InService
#
LB_NAME=$1
AWS_PROFILE=prod aws elb describe-instance-health \
   --load-balancer-name="${LB_NAME}" \
   --query 'InstanceStates[?State==`InService`].InstanceId'
 
#
# register instances with ELB
#
AWS_PROFILE=prod aws elb register-instances-with-load-balancer \
  --load-balancer-name ${LB_NAME} \
  --instances <from_table>
