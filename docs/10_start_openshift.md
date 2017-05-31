# Fire up OpenShift

This section will start a new local OpenShift (single node) cluster
using "MiniShift".

## Install docker machine support

Minishift makes use of "Docker machine" and thus may need a docker machine addon for your
local system. Assuming that you are running on CentOS/RHEL 7, you will need to install the
addon according to the following documentation:

https://docs.openshift.org/latest/minishift/getting-started/docker-machine-drivers.html

## Install OpenShift Client

TO BE WRITTEN

## Install MiniShift

MiniShift is a simple download which needs to be unzipped. This tutorial is using
MiniShift 1.0.1. But you can also look up the most recent release here: https://github.com/minishift/minishift/releases

    wget https://github.com/minishift/minishift/releases/download/v1.0.1/minishift-1.0.1-linux-amd64.tgz
    tar xzf minishift-1.0.1-linux-amd64.tgz
    ./minishift start --metrics --memory  8192

## Install Hawkular OpenShift Agent

    oc login -u system:admin
    oc create -f remote/hawkular-openshift-agent/deploy/openshift/hawkular-openshift-agent-configmap.yaml -n openshift-infra
    oc process -f remote/hawkular-openshift-agent/deploy/openshift/hawkular-openshift-agent.yaml IMAGE_VERSION=1.4.1.Final | oc create -n openshift-infra -f -
    oc adm policy add-cluster-role-to-user hawkular-openshift-agent system:serviceaccount:openshift-infra:hawkular-openshift-agent
    oc login -u developer

## Access OpenShift

After the MiniShift instance is running, you can log on to the console:

    ./minishift console
