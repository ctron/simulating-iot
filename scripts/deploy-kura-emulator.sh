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

openshift_create_new_project "$KURA_EMULATOR_PROJECT_NAME"

oc process \
 -n "$KURA_EMULATOR_PROJECT_NAME" \
 -f "$KURA_EMULATOR_BASE_DIR/openshift/kura-template.yml" | oc create -n "$KURA_EMULATOR_PROJECT_NAME" -f -

oc status -n "$KURA_EMULATOR_PROJECT_NAME"

$SCRIPT_BASE/show-information.sh --kura-emulator

echo "$(em Note:) This will actually build the Kura emulator from scratch in OpenShift"
echo "As this may take a while (~15 min), you need to be patient."