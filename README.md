Pin 2 Grupo 3 
Integrantes: 
  - Gonzalo Rodríguez
  - Ethan 
  - Eduardo Galera

Creamos un cluster EKS con 3 pods con nginx, grafana y prometheus desde una instancia Ec2 

Pasos que se sigueron en el trabajo: 
  1- Creamos una VPC
  •	AWS VPC (10.0.0.0/16): Contiene dos subredes: una pública y una privada.
  •	Subnet Pública (10.0.1.0/24): Donde se lanza la instancia EC2 con acceso a Internet.
  •	Subnet Privada (10.0.2.0/24): Para recursos que no necesitan acceso directo a Internet.
  •	Puerta de Enlace de Internet (Internet Gateway): Conecta la VPC a Internet.
  •	Grupo de Seguridad (Security Group): Controla el tráfico entrante y saliente (SSH, HTTP).
  •	Tabla de Enrutamiento (Route Table): Dirige el tráfico dentro y fuera de la VPC.

  script: vpcInstanciaEc2.sh

  2- Creamos la instancia EC2 
  - AMI_ID="ami-005fc0f236362e99f"
  - INSTANCE_TYPE="t2.micro"
  - REGION="us-east-1"
  - VPC_ID="vpc-02952482ac2a39039"
  - KEY_NAME="pods-eks-acceso"

  script: instanciaEc2.sh

  3- Creamos un rol para la instancia EC2
  - ec2-admin
   
  {
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }

 script: rol_ec2_admin.sh 
 trusp-policy.json

  4- Ingresamos a la instancia EC2 a travez de ssh para instalar:
  - Docker
  - Helm
  - Kubectl
  - aws cli

  script: setup.sh
    
 5- Conectados a la instancia EC2 via ssh generamos la un cluster EKS
 - Instalamos eksctl
 script: eksctl.sh

CREAMOS ROLES PARA EKS Y LOS NODOS EKS 

 6- Creamos un rol IAM para EKS 
 - rol_eks.sh
 - trust-policy.json

  7- Cremos un rol IAM para los nodos EKS
  - rol_nodos_eks.sh
  - trust-policy.json

CREAMOS EL CLUSTER

  8- Creamos un cluster eks con los tres pods y los roles a travez de un script
 - cluster.yml
 - script: desploy_eks_cluster.sh

DESPLEGAMOS NGINX - PROMETHUES - GRAFANA
  9- NGINX con el escript
  - nginx_deployment.yaml
  - script: nginx.sh

 10- Promethues
 - prometheus.sh
 - prometheus.deployment.yaml

  11- Grafana 
  - despliegue_grafana.sh
  - grafna_deployment.yaml


 
# pin2-grupo3-final
