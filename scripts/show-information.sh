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

# parse arguments

grafana=0
metrics=0
kapua=0
kura_emulator=0
kura_simulator=0

for arg in "$@" ; do
	case "$arg" in
		--metrics) grafana=1 ; metrics=1 ;;
		--kapua) kapua=1 ;;
		--kura-emulator) kura_emulator=1 ;;
		--kura-simulator) grafana=1 ; kura_simulator=1 ;;
	esac
done

# no arguments? then default to all

[[ "$#" -le 0 ]] && { grafana=1 ; metrics=1 ; kapua=1 ; kura_emulator=1 ; kura_simulator=1 ; }

wants () {
	test "$1" -ne 0
	return $?
}

# run

wants $kura_emulator && openshift_project_exists "$KURA_EMULATOR_PROJECT_NAME" && cat << __EOF__

$(h1 Kura Cloud Services)

  $(em Data Service)

    $(em connect.auto-on-startup):    true

  $(em MqttDataTransport)

    $(em broker-url:)                 mqtt://broker-eclipse-kapua.$(minishift ip).nip.io:31883
    $(em topic.context.account-name:) kapua-sys
    $(em username:)                   kapua-broker
    $(em password:)                   kapua-password
    $(em client:)                     emulator-1

__EOF__

wants $grafana && { echo ; echo "$(h1 Grafana datasources:)" ; }

wants $metrics && cat << __EOF__

    Name:       metrics
    Type:       Hawkular
    URL:        https://metrics-openshift-infra.$(minishift ip).nip.io/hawkular/metrics
    Access:     proxy
    Tenant:     ${KAPUA_PROJECT_NAME}
    Token:      $(oc whoami -t)     $(comment \# update every 24 hours)
__EOF__

wants $kura_simulator && openshift_project_exists "$KAPUA_PROJECT_NAME" && cat << __EOF__

    Name:       kapua
    Type:       Elasticsearch
    URL:        $(service_url "eclipse-kapua" "elasticsearch")
    Access:     proxy
    Index Name: [1]-YYYY-WW    Pattern: Weekly
    Time field: timestamp
    Version:    5.x
__EOF__

cat << __EOF__

$(h1 Web UIs:)

__EOF__

wants $kapua && openshift_project_exists "$KAPUA_PROJECT_NAME" && cat << __EOF__
    $(em Kapua Console:) $(service_url "eclipse-kapua" "console")
           User: kapua-sys
       Password: kapua-password

__EOF__

wants $grafana && openshift_project_exists "$GRAFANA_PROJECT_NAME" && cat << __EOF__
    $(em Grafana:)       $(service_url "grafana" "hawkular-grafana")
           User: admin
       Password: admin

__EOF__

wants $kura_emulator && openshift_project_exists "$KURA_EMULATOR_PROJECT_NAME" && cat << __EOF__
    $(em Kura Emulator:) $(service_url "kura-emulator" "console")
           User: admin
       Password: admin

__EOF__

echo

