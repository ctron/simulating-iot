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

log "Creating project '$KAPUA_PROJECT_NAME'"

openshift_create_new_project "$KAPUA_PROJECT_NAME"

log "Deploying Kapua"

oc new-app \
	-n "$KAPUA_PROJECT_NAME" \
	-f "$KAPUA_BASE_DIR/dev-tools/src/main/openshift/kapua-template.yml" \
	-p "DOCKER_ACCOUNT=$KAPUA_DOCKER_ACCOUNT" \
	-p "IMAGE_VERSION=$KAPUA_IMAGE_VERSION"

oc create -f "$SCRIPT_BASE/../config/eclipse-kapua-elasticsearch.yml"

oc status -n "$KAPUA_PROJECT_NAME"

$SCRIPT_BASE/show-information.sh --kapua
