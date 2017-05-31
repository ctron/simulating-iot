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

oc login -u system:admin

trap "oc login -u developer" EXIT

oc create -f remote/hawkular-openshift-agent/deploy/openshift/hawkular-openshift-agent-configmap.yaml -n openshift-infra
oc process -f remote/hawkular-openshift-agent/deploy/openshift/hawkular-openshift-agent.yaml IMAGE_VERSION=1.4.1.Final | oc create -n openshift-infra -f -
oc adm policy add-cluster-role-to-user hawkular-openshift-agent system:serviceaccount:openshift-infra:hawkular-openshift-agent
