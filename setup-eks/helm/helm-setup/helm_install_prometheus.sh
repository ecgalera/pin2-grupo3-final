#!/bin/bash

# Instalo Prometheus 

helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --create-namespace

# Verificamos la instalación

kubectl get all -n monitoring
