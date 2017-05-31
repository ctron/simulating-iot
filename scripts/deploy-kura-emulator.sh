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

"$OC" process \
 -n "$KURA_EMULATOR_PROJECT_NAME" \
 -f "$KURA_EMULATOR_BASE_DIR/openshift/kura-template.yml" | oc create -n "$KURA_EMULATOR_PROJECT_NAME" -f -

"$OC" status -n "$KURA_EMULATOR_PROJECT_NAME"

echo
echo Configure Kura to use:
echo    Account Name: kapua-sys
echo    User:         kapua-broker
echo    Password:     kapua-password
echo    Broker URL:   mqtt://broker-eclipse-kapua.$(minishift ip).nip.io:31883
echo    Client ID:    emulator-1
echo