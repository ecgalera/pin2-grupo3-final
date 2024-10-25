#!/bin/bash

# Añadir la clave GPG de Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

# Instalar apt-transport-https
sudo apt-get install apt-transport-https --yes

# Añadir el repositorio de Helm
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

# Actualizar los repositorios
sudo apt-get update

# Instalar Helm
sudo apt-get install helm -y

# Verificar la instalación
helm version
