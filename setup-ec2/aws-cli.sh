#!/bin/bash

# Instrucciones: 
# 1- Ingresar con ssh -i /dirección_del_archivo.pem ubuntu@la_ip_publica_del_ec2
# 2- crear el archivo con el contenido del script setup.sh (nano setup.sh)
# 3- chmod +x setup.sh
# 4- ./setup.sh

# Actualizar el sistema y los paquetes
sudo apt update -y
sudo apt upgrade -y

# Instalar AWS CLI
sudo apt install -y awscli
aws --version

