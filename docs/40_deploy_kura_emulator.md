# Deploy Kura Emulator

From the root of the repository run:

    ./scripts/deploy-kura-emulator.sh

This actually makes a full build of the Kura emulator image and may take
long time (~30 minutes). You can check the progress from the OpenShift
web console.

After the build has finished navigate to the URL printed out at the
end of the line for the Web Console:

e.g. http://console-kura-emulator.192.168.12.34.nip.io

## Configure connection to Kapua

In the "Cloud Services" section:
* Data Service
    * connect.auto-on-startup : true
* MqttDataTransport
    * broker-url : mqtt://broker-eclipse-kapua.192.168.12.34.nip.io:31883
    * topic.context.account-name : kapua-sys
    * username : kapua-broker
    * password : kapua-password
* Press the "Connect" button

## Checking the result

* Log in to Kapua
* Switch to "devices" and check for a device named `emulator-1`
