# Pre-requisites

This tutorial assumes you are running on RHEL/CentOS 7.

However it should work quite similar on other Linux distributions
and even Mac OS X or Windows.

You will need a x86_64 host system with at least 16 GB RAM, 40 GB disk space
and virtualization capabilities.

All commands a local to the root of this repository.

The URLs used in this tutorial to access resources on the OpenShift cluster
are using the hostname pattern `http://resource-name.192.168.12.34.nip.io`.
This uses a DNS resolution service which will actually parse the DNS name as IP
address and use it as result. The IP address of your local OpenShift instance
will be different and thus you will need to replace it. The IP address of your
local installation can be lookup up by executing `minishift ip`.