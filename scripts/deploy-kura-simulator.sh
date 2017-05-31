#!/usr/bin/env bash

###############################################################################
# Copyright (c) 2017 Red Hat Inc and others
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
###############################################################################

set -e

# source commons
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/common.sh"

openshift_ping

openshift_create_new_project "$KURA_SIMULATOR_PROJECT_NAME"

BROKER_URL="tcp://${KAPUA_BROKER_USER}:${KAPUA_BROKER_PASSWORD}@$(minishift ip):31883"

log "Using broker: $BROKER_URL"

oc new-app \
 -n "$KURA_SIMULATOR_PROJECT_NAME" \
 -f "$KAPUA_BASE_DIR/simulator-kura/openshift/external-template.yml" \
 -p "DOCKER_ACCOUNT=$KURA_SIMULATOR_DOCKER_ACCOUNT" \
 -p "IMAGE_VERSION=$KURA_SIMULATOR_IMAGE_VERSION" \
 -p "BROKER_URL=$BROKER_URL" \

"$OC" -n "$KURA_SIMULATOR_PROJECT_NAME" create configmap data-simulator-config --from-file=KSIM_SIMULATION_CONFIGURATION=${SCRIPT_BASE}/../config/simulator1.json
"$OC" -n "$KURA_SIMULATOR_PROJECT_NAME" set env --from=configmap/data-simulator-config dc/simulator

"$OC" status -n "$KURA_SIMULATOR_PROJECT_NAME"
