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

project="$1"

test -n "$project" || die "Missing project name: ./delete.sh <project>"

log "Testing OpenShift connectivity"

oc projects &>/dev/null || die "OpenShift seems to be unreachable. Are you logged in?"

log "Deleting project '$project'"

oc delete "project/$project"

log "Waiting to project deletion"

while oc describe "project/$project" &>/dev/null; do
	sleep 10
	log "Still waiting..."
done

echo $(em Note:) Sometimes the detection if the project deletion has been completed
echo doesn\'t properly work. Give it some time and re-try to deploy command
echo failed. 