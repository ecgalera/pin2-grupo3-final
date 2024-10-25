#!/bin/bash

# Instalar `eksctl`
curl -sL "https://github.com/weaveworks/eksctl/releases/download/v0.193.0/eksctl_Linux_amd64.tar.gz" -o eksctl.tar.gz
tar -xzf eksctl.tar.gz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
rm eksctl.tar.gz

# Verificar la instalación
eksctl version

