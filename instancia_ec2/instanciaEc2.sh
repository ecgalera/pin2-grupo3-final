#!/bin/bash

# Nombre de la VPC
VPC_NAME="VpcEc2"

# Obtener el ID de la VPC
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=$VPC_NAME" --query "Vpcs[0].VpcId" --output text)
echo "VPC ID: $VPC_ID"

# Obtener el ID de la Subred Pública
SUBNET_PUBLICA_ID=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" "Name=tag:Name,Values=SubnetPublica" --query "Subnets[0].SubnetId" --output text)
echo "Subred Pública ID: $SUBNET_PUBLICA_ID"

# Obtener el ID de la Subred Privada
SUBNET_PRIVADA_ID=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" "Name=tag:Name,Values=SubnetPrivada" --query "Subnets[0].SubnetId" --output text)
echo "Subred Privada ID: $SUBNET_PRIVADA_ID"

# Obtener el ID del Internet Gateway
GATEWAY_ID=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VPC_ID" --query "InternetGateways[0].InternetGatewayId" --output text)
echo "Internet Gateway ID: $GATEWAY_ID"

# Obtener el ID de la Tabla de Enrutamiento
TABLA_ENRUTAMIENTO_ID=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID" --query "RouteTables[0].RouteTableId" --output text)
echo "Route Table ID: $TABLA_ENRUTAMIENTO_ID"

# Obtener el ID del Grupo de Seguridad
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=default" --query "SecurityGroups[0].GroupId" --output text)
echo




#VPC_ID="vpc-02952482ac2a39039"
#SUBNET_Publica_ID="subnet-0e9963c417e2bd9d8"
#SUBNET_Privada_ID="subnet-09d4f7463353dc0e8"
#GATEWAY_ID="igw-05eb5fc09c43b718e"
#Tabla_Enrutamiento_ID="rtb-02f4161ac216a57f6"
KEY_NAME="pods-eks-acceso"
AMI_ID="ami-005fc0f236362e99f"
INSTANCE_TYPE="t2.micro"
Security_Group_ID="sg-032a644115c9d556d"
REGION="us-east-1"

# Crear una instancia EC2 sobre la VPC

INSTANCE_EC2_ID=$(aws ec2 run-instances \
  --image-id ami-005fc0f236362e99f \
  --count 1 \
  --instance-type t2.micro \
  --key-name pods-eks-acceso \
  --subnet-id $SUBNET_PUBLICA_ID \
  --security-group-ids $SECURITY_GROUP_ID \
  --query 'Instances[0].InstanceId' \
  --output text \
  --region us-east-1 \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MiInstanciaEc2}]')
echo "Instancia EC2 lanzada con Id: $INSTANCE_EC2_ID"

