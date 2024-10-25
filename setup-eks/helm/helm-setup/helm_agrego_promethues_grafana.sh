#!/bin/bash

# agrego los repositorios de Gafana y Prometheus en helm 

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
