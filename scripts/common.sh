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

SCRIPT_BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

 : KAPUA_IMAGE_VERSION=${KAPUA_IMAGE_VERSION:=2017-05-31}
 : KAPUA_DOCKER_ACCOUNT=${KAPUA_DOCKER_ACCOUNT:=kapua}
 : KURA_SIMULATOR_IMAGE_VERSION=${KURA_SIMULATOR_IMAGE_VERSION:=2017-05-31}
 : KURA_SIMULATOR_DOCKER_ACCOUNT=${KURA_SIMULATOR_DOCKER_ACCOUNT:=kapua}

 : KAPUA_PROJECT_NAME=${KAPUA_PROJECT_NAME:=eclipse-kapua}
 : KURA_EMULATOR_PROJECT_NAME=${KURA_EMULATOR_PROJECT_NAME:=kura-emulator}
 : KURA_SIMULATOR_PROJECT_NAME=${KURA_SIMULATOR_PROJECT_NAME:=kura-simulator}
 : GRAFANA_PROJECT_NAME=${GRAFANA_PROJECT_NAME:=grafana}

 : KAPUA_BASE_DIR=${KAPUA_BASE_DIR:=${SCRIPT_BASE}/../remote/kapua} 
 : KURA_EMULATOR_BASE_DIR=${KURA_EMULATOR_BASE_DIR:=${SCRIPT_BASE}/../remote/kura-emulator}
 : KAPUA_BROKER_USER=${KAPUA_BROKER_USER:=kapua-broker}
 : KAPUA_BROKER_PASSWORD=${KAPUA_BROKER_PASSWORD:=kapua-password}

die() { printf "$@" 1>&2 ; echo 1>&2 ; exit 1; }

log() { echo "$@"; }

openshift_ping () {
	log "Testing OpenShift connectivity"
	"$OC" projects &>/dev/null || die "OpenShift seems to be unreachable. Are you logged in?"
}

openshift_project_exists () {
	local project="$1"
	"$OC" describe "project/$project" &>/dev/null
	return $?
}

openshift_create_new_project () {
	local project="$1"
	openshift_project_exists "$project" && die "OpenShift project '$project' already exists. You can delete it with: \n\n\tscripts/delete.sh $project\n"
	
	"$OC" new-project "$project" 1>/dev/null
}

eval $(minishift oc-env)
OC=$(which oc 2>/dev/null) || die "Unable to find 'oc' binary in the path"
