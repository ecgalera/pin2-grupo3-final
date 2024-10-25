#!/bin/bash

helm install grafana grafana/grafana \
  --namespace monitoring \
  --set adminPassword='admin' \
  --set service.type=LoadBalancer

# Verificar instalaciones

kubectl get all -n monitoring

# Accedemos a grafana 

kubectl get svc -n monitoring grafana

# La IP se mostrará en la columna EXTERNAL-IP. Ingresa esa IP en tu navegador para acceder a la interfaz de Grafana.
# Usa admin tanto para el usuario como para la contraseña (puedes cambiar esto más tarde por razones de seguridad).