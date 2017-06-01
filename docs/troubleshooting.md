# Troubleshooting

Shit happens …

## Certificate errors

OpenShift uses self-signed certificates and using Minishift it seems that
also the host names differ between the actual hostnames and the ones in the
certificates.

One 🤦 and adding exceptions for those certificates helps.

## I think I messed it up

You can already delete the complete setup by deleting the OpenShift cluster:

    minishift delete

> "Restart? Restore? At least once more!!!"

## OpenShift Metrics don't work

Please also have a look at fixing [Certificate errors](#certificate-errors) as this also
blocks the web browser from loading OpenShift metrics information.

If that doesn't help and you get a screen "Application is not available" this can be due
to the fact that the metrics system is not (yet) fully deployed.

For the following commands to work you will need to switch to the admin user and the
`openshift-infra` project: 

    oc login -u system:admin
    oc project openshift-infra

**Note:** Be sure to switch back to the developer user later on:

    oc login -u developer

You can then check this with:

    oc get pods

Which should print out something like:

    NAME                         READY     STATUS      RESTARTS   AGE
    hawkular-cassandra-1-36l1p   1/1       Running     0          11m
    hawkular-metrics-n2xqk       1/1       Running     0          11m
    heapster-p5lzq               1/1       Running     0          11m
    metrics-deployer-pod-36q6p   0/1       Completed   0          12m

If e.g. the `hawkular-metrics-xxxxx` pod is not ready after some time, it may
be that something when wrong during startup. For me it helped to kill the pod with:

    oc delete pod/hawkular-metrics-xxxxx
    
Which will kill and restart the pod.
