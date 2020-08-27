#!/bin/sh

set -e

cd ${CHART_DIR}

helm lint . ${LINT_ARGS}
helm package .
