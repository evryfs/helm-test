#!/usr/bin/env bash

set -e

CHARTS_PATH=$1
echo "Charts dir: ${CHARTS_PATH}"
helm repo add evryfs-helm https://fsdepot.evry.com/nexus/repository/evryfs-helm/
helm nexus-push evryfs-helm login -u $USERNAME -p $PASSWORD

function pushChart {
  echo "Processing `pwd`"
  helm package --save=false .
  CHART_VERSION=$(yq read Chart.yaml version)
  CHART_NAME=$(yq read Chart.yaml name)
  #ls -l ${CHART_NAME}-${CHART_VERSION}.tgz
  #cloudctl catalog load-chart --archive ${CHART_NAME}-${CHART_VERSION}.tgz
  helm nexus-push evryfs-helm .
}

for chart in ${CHARTS_PATH}/*; do (cd "$chart" && pushChart); done
  
