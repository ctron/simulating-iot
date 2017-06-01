# Deploy Kura Emulator

From the root of the repository run:

    ./scripts/deploy-kura-emulator.sh

This actually makes a full build of the Kura emulator image and may take
long time (~30 minutes). You can check the progress from the OpenShift
web console.

## Configure connection to Kapua

Navigate to the Kura Emulator web console.

In the "Cloud Services" section enter the data as printed out by:

    ./scripts/show-information.sh --kura-emulator

Press the "Connect" button!

## Checking the result

* Log in to Kapua
* Switch to "devices" and check for a device named `emulator-1`

## Playing around

You can now query this device for bundles, start/stop them and also "install"
new packages. However these are all simulated operations and will not really
start/stop or install anything.
