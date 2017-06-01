# Pre-requisites

For this tutorial to work, you will need a few pre-requisites
and should be aware of a few things.

## Environment/OS

This tutorial assumes you are running on RHEL/CentOS 7.

However it should work quite similar on other Linux distributions,
even Mac OS X or Windows. But you may required additional tools
or commands might be a little bit different. However those setups are
not tested.

You will need a x86_64 host system with at least 32 GB RAM, 40 GB disk space
and virtualization capabilities.

## Commands

All commands a local to the root of this repository and are written in `bash`.

This should work out-of-the-box on Mac OS, but on Windows you will need to install
some kind of "bash".

## URLs

The URLs used in this tutorial to access resources on the OpenShift cluster
are using the hostname pattern `http://resource-name.192.168.12.34.nip.io`.
This uses a DNS resolution service which will actually parse the DNS name as IP
address and use it as result. The IP address of your local OpenShift instance
will be different and thus you will need to replace it. The IP address of your
local installation can be lookup up by executing `minishift ip`.

## Certificate issues

Minishift uses self-signed certificates and has some issues creating proper
host names. You will to let your browser ignore them.

Also see: [Certificates](troubleshooting.md#certificate-issues). 