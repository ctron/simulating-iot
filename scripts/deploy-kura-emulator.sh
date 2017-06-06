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
-f "$KURA_EMULATOR_BASE_DIR/extensions/artemis/openshift-template.yml" | oc create -n "$KURA_EMULATOR_PROJECT_NAME" -f -

oc status -n "$KURA_EMULATOR_PROJECT_NAME"

$SCRIPT_BASE/show-information.sh --kura-emulator

echo
echo "$(em Note:) This will build the Artemis extension image based on the Kura"
echo "Emulator image. This build make take a few minutes, Kura will be started"
echo "once the build is complete."
echo