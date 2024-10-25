#!/bin/bash

# Instrucciones: 
# 1- Ingresar con ssh -i /dirección_del_archivo.pem ubuntu@la_ip_publica_del_ec2
# 2- crear el archivo con el contenido del script setup.sh (nano setup.sh)
# 3- chmod +x setup.sh
# 4- ./setup.sh

# Ejecutamos la configuración del cluster

eksctl create cluster -f cluster_eks.yaml

