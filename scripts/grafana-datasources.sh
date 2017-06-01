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

cat << __EOF__

Now configure your Grafana datasources with:

    Name:       metrics
    Type:       Hawkular
    URL:        https://metrics-openshift-infra.$(minishift ip).nip.io/hawkular/metrics
    Access:     proxy
    Tenant:     ${KAPUA_PROJECT_NAME}
    Token:      $(oc whoami -t)

    Name:       kapua
    Type:       Elasticsearch
    URL:        https://elasticsearc-eclipse-kapua.$(minishift ip).nip.io
    Access:     proxy
    Index Name: [1]-YYYY-WW    Pattern: Weekly
    Time field: timestamp
    Version:    5.x

__EOF__
