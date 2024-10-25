#!/bin/bash

# Instrucciones: 
# 1- Ingresar con ssh -i /dirección_del_archivo.pem ubuntu@la_ip_publica_del_ec2
# 2- crear el archivo con el contenido del script setup.sh (nano setup.sh)
# 3- chmod +x setup.sh
# 4- ./setup.sh

# Actualizar el sistema y los paquetes
sudo apt update -y
sudo apt upgrade -y

# Download the latest release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Vaidamos el archivo descargado
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Instalamos kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Comprobamos la instalación
kubectl version --client