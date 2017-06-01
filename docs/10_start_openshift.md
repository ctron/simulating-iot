# Fire up OpenShift

This section will start a new local OpenShift (single node) cluster
using [MiniShift](https://github.com/minishift/minishift).

## Install docker machine support

Minishift makes use of "Docker machine" and thus may need a docker machine addon for your
local system. Assuming that you are running on CentOS/RHEL 7, you will need to install the
addon according to the following documentation:

https://docs.openshift.org/latest/minishift/getting-started/docker-machine-drivers.html

## Install MiniShift

MiniShift is a simple download which needs to be unzipped:

    wget https://github.com/minishift/minishift/releases/download/v1.0.1/minishift-1.0.1-linux-amd64.tgz
    tar xzf minishift-1.0.1-linux-amd64.tgz
    ./minishift start --metrics --memory 16384

This tutorial is using MiniShift 1.0.1. But you can also look
up the most recent release here: https://github.com/minishift/minishift/releases

## Install the Hawkular OpenShift Agent

For gathering custom metrics from the Kapua containers we will need to install
the Hawkular OpenShift agent: 

    ./scripts/deploy-hawkular.sh

## Access OpenShift

After the MiniShift instance is running, you can log on to the OpenShift console:

    ./minishift console
