#!/usr/bin/env bash

set -e

CHARTS_PATH=$1
echo "Charts dir: ${CHARTS_PATH}"
helm repo add evryfs-helm https://fsdepot.evry.com/nexus/repository/evryfs-helm/
helm nexus-push evryfs-helm login -u $USERNAME -p $PASSWORD

function pushChart {
  echo "Processing `pwd`"
  helm package --save=false .
  USERNAME="" helm nexus-push evryfs-helm .
}

for chart in ${CHARTS_PATH}/*; do (cd "$chart" && pushChart); done
  
