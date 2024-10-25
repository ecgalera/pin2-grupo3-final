# Creamos una VPC para una instancia EC2:
# VPC red virtual aislada logicamente en la que se alojan los recursos

# 1 - Creo la VPC
# aws ec2 create-vpc --cidr-block 10.0.0.0/16

# # Creamos la VPC de forma que pueda usar el id con VPC_ID
# VPC_ID = $(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'vpc.Vpc.Id' --output text)
# echo 'VPC ID: $VPC_ID'

# # Le pongo un nombre a la VPC creada 
# aws ec2 create-tags --resources $VPC_ID --tags key=Name, Value= 'VpcEc2'

# # 2 - Creamos una subred pública 
# SUBNET_Publica_ID = $(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --query 'Subnet.SubnetId' --output text)

# # Le pongo un nombre a la Subred Publica
# aws ec2 create-tags --resources $SUBNET_Publica_ID --tags key=Name , Value= 'SubnetPublica'

# # 3 - Creo la subred privada 
 
# SUBNET_Privada_ID = $(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24 --query 'Subnet.SubnetId' --output text)

# # Le pongo nombre a la subnet privada
# aws ec2 create-tags --resources $SUBNET_Privada_ID --tags key=Name , Value= 'SubnetPrivada'

# # Creamos el enlace a internet GATEWAY 
# GATEWAY_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)

# # Le pongo nombre al Gateway 
# aws ec2 create-tags -resources $GATEWAY_ID --tags key= Name , Value = 'Gateway_Ec2'

# # Actualizamos las tablas de enrutamiento para las subredes públicas
# # 1 - Creamos la tabla de enrutamiento y la unimos con la VPC
# ROUTE_TABLE_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --query 'RouteTable.RouteTableId' --output text)
# # 2 - Agregamos una ruta hacia el Intenet Gateway en la tabla de enrutamiento
# aws ec2 create-ruoute --route-table-id $ROUTE_TABLE_ID --destination -cidr-block 0.0.0.0/0 --gateway-id $GATEWAY_ID
# # 3- Asociamos la tabla de enrutamiento con la subred publica 
# aws ec2 associate-route-table --subnet-id $SUBNET_PUBLIC_ID --route-table-id $ROUTE_TABLE_ID

# # Modifico la subred publica para permitir la asignacion automatica de la IP publica
# aws ec2 modify-subnet-attribute --subnet-id $SUBNET_PUBLIC_ID --map-public-ip-on-luanch

# Creamos la VPC y obtenemos su ID
VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
echo "VPC ID: $VPC_ID"

# Le ponemos un nombre a la VPC creada
aws ec2 create-tags --resources $VPC_ID --tags Key=Name,Value="VpcEc2"

# 2 - Creamos una subred pública
SUBNET_Publica_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --query 'Subnet.SubnetId' --output text)
echo "Subred Pública ID: $SUBNET_Publica_ID"

# Le ponemos un nombre a la Subred Pública
aws ec2 create-tags --resources $SUBNET_Publica_ID --tags Key=Name,Value="SubnetPublica"

# 3 - Creamos la subred privada
SUBNET_Privada_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24 --query 'Subnet.SubnetId' --output text)
echo "Subred Privada ID: $SUBNET_Privada_ID"

# Le ponemos nombre a la subred privada
aws ec2 create-tags --resources $SUBNET_Privada_ID --tags Key=Name,Value="SubnetPrivada"

# Creamos el enlace a internet (Internet Gateway)
GATEWAY_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
echo "Gateway ID: $GATEWAY_ID"

# Le ponemos nombre al Gateway
aws ec2 create-tags --resources $GATEWAY_ID --tags Key=Name,Value="Gateway_Ec2"

# Unimos el Internet Gateway con la VPC
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $GATEWAY_ID

# Creamos la tabla de enrutamiento y la unimos con la VPC
ROUTE_TABLE_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --query 'RouteTable.RouteTableId' --output text)
echo "Tabla de Enrutamiento ID: $ROUTE_TABLE_ID"

# Agregamos una ruta hacia el Internet Gateway en la tabla de enrutamiento
aws ec2 create-route --route-table-id $ROUTE_TABLE_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $GATEWAY_ID

# Asociamos la tabla de enrutamiento con la subred pública
aws ec2 associate-route-table --subnet-id $SUBNET_Publica_ID --route-table-id $ROUTE_TABLE_ID

# Modificamos la subred pública para permitir la asignación automática de IP públicas
aws ec2 modify-subnet-attribute --subnet-id $SUBNET_Publica_ID --map-public-ip-on-launch

# Crear el grupo de seguridad para SSH y HTTP
SG_ID=$(aws ec2 create-security-group --group-name my-security-group --description "Grupo de Seguridad para SSH y HTTP" --vpc-id $VPC_ID --query 'GroupId' --output text)
echo "Security Group ID: $SG_ID"

# Añadir reglas al grupo de seguridad
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr 0.0.0.0/0

# Le ponemos un nombre al Security Group
aws ec2 create-tags --resources $SG_ID --tags Key=Name,Value="MySecurityGroup"

echo "Configuración completada."