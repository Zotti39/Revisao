#!/bin/bash
### Instala o Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

### Adiciona os repositorios necessarios
helm repo add stable https://charts.helm.sh/stable
### Parte que adiciona os repos do prometheus. Não é necessario nesta etapa
### helm repo add prometheus-community https://prometheus-community.github.io/helm-chart
### kubectl create namespace prometheus
