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
kapua=0
kura_emulator=0

for arg in "$@" ; do
	case "$arg" in
		--grafana) grafana=1 ;;
		--kapua) kapua=1 ;;
		--kura-emulator) kura_emulator=1 ;;
	esac
done

# no arguments? then default to all

[[ "$#" -le 0 ]] && { grafana=1 ; kapua=1 ; kura_emulator=1; }

wants () {
	test "$1" -ne 0
	return $?
}

# run

wants $kura_emulator && openshift_project_exists "kura-emulator" && cat << __EOF__

$(h1 Kura Cloud Service:)

   Account Name: kapua-sys
   User:         kapua-broker
   Password:     kapua-password
   Broker URL:   mqtt://broker-eclipse-kapua.$(minishift ip).nip.io:31883
   Client ID:    emulator-1

__EOF__

wants $grafana && cat << __EOF__

$(h1 Grafana datasources:)

    Name:       metrics
    Type:       Hawkular
    URL:        https://metrics-openshift-infra.$(minishift ip).nip.io/hawkular/metrics
    Access:     proxy
    Tenant:     ${KAPUA_PROJECT_NAME}
    Token:      $(oc whoami -t)     $(comment \# update every 24 hours)
__EOF__

wants $grafana && openshift_project_exists "eclipse-kapua" && cat << __EOF__

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

wants $kapua && openshift_project_exists "eclipse-kapua" && cat << __EOF__
    $(em Kapua Console:) $(service_url "eclipse-kapua" "console")
           User: kapua-sys
       Password: kapua-password

__EOF__

wants $grafana && openshift_project_exists "grafana" && cat << __EOF__
    $(em Grafana:)       $(service_url "grafana" "hawkular-grafana")
           User: admin
       Password: admin

__EOF__

wants $kura_emulator && openshift_project_exists "kura-emulator" && cat << __EOF__
    $(em Kura Emulator:) $(service_url "kura-emulator" "console")
           User: admin
       Password: admin

__EOF__

echo

