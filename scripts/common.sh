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

em() { tput bold ; echo -n "$@" ; tput sgr0 ; }
ul() { tput smul ;echo -n "$@" ; tput rmul ; }
comment() { tput dim ; echo -n "$@" ; tput sgr0 ; }
h1() { tput bold ; tput smul ; echo -n "$@" ; tput sgr0 ; }

service_url () {
	local ns="$1"
	local service="$2"
	minishift openshift service "$2" -n "$1" --url
}

openshift_login() {
	local user="$1"
	log "Switching user to: $user"
	oc login -u "$user" 1>/dev/null
}

openshift_ping () {
	log "Testing OpenShift connectivity"
	oc projects &>/dev/null || die "OpenShift seems to be unreachable. Are you logged in?"
}

openshift_project_exists () {
	local project="$1"
	oc describe "project/$project" &>/dev/null
	return $?
}

openshift_create_new_project () {
	local project="$1"
	openshift_project_exists "$project" && die "OpenShift project '$project' already exists. You can delete it with: \n\n\tscripts/delete.sh $project\n"
	
	oc new-project "$project" 1>/dev/null
}

eval $(minishift oc-env)

# test for "oc" binary
which oc &>/dev/null || die "Unable to find 'oc' binary in the path"

test -f "$SCRIPT_BASE/../remote/kura-emulator/README.md" || die "Unable to find remote repository content. Are the git submodules initialized? You can do this by executing:\n\n\tgit submodule update --init"
