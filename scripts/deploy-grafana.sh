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

openshift_create_new_project "$GRAFANA_PROJECT_NAME"

#oc new-app \
# -n "$GRAFANA_PROJECT_NAME" \
# -f https://raw.githubusercontent.com/hawkular/hawkular-grafana-datasource/v1.0.8/docker/openshift/openshift-template-ephemeral.yaml

oc new-app \
 -n "$GRAFANA_PROJECT_NAME" \
-f https://raw.githubusercontent.com/hawkular/hawkular-grafana-datasource/master/docker/openshift/openshift-template-ephemeral.yaml


oc status -n "$GRAFANA_PROJECT_NAME"

echo
echo Now configure your Grafana datasources with:
echo
echo "    Type:       Hawkular"
echo "    Name:       metrics"
echo "    URL:        https://metrics-openshift-infra.$(minishift ip).nip.io/hawkular/metrics"
echo "    Access:     proxy"
echo "    Tenant:     ${KAPUA_PROJECT_NAME}"
echo "    Token:      $(oc whoami -t)"
echo
echo "    Type:       Elasticsearch"
echo "    Name:       kapua
echo "    URL:        https://elasticsearc-eclipse-kapua.$(minishift ip).nip.io"
echo "    Access:     proxy"
echo "    Index Name: [1]-YYYY-WW    Pattern: Weekly"
echo "    Time field: timestamp"
echo "    Version:    5.x"
echo
