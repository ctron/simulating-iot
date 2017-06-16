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


PROJECTS="$KAPUA_PROJECT_NAME $KURA_EMULATOR_PROJECT_NAME $KURA_SIMULATOR_PROJECT_NAME $GRAFANA_PROJECT_NAME"

openshift_ping

for i in $PROJECTS; do
	oc delete "project/$i"
done

echo
echo $(em Note:) Deleting all projects may take a while and although
echo projects may not be visible, they still may exists for a bit
echo until they are completely deleted.
echo