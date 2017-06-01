# Deploy the Kura Simulator

From the root of the repository run:

    ./scripts/deploy-kura-simulator.sh

This creates a new instance of the Kura simulator and configures
it to use the configuration from `config/simulator1.json`, which
creates a set of sine curves as data.

## Checking for data

Check if data is received by Kapua:

* Log in to Kapua
* Switch to the "Data" view
* Query for data of `app1`

## Visualizing data with Grafana

* Create the datasource `kapua` with the parameters shown by `./scripts/show-information.sh --grafana`
* Import the dashboard from `config/grafana/simulator-data.json`
    * Select the datasource `kapua`

## Scaling up

Scale up the number of containers:

    oc scale --replicas=10 dc simulator

Scale up the number of instances inside a single container:

    oc set env dc/simulator KSIM_NUM_GATEWAYS=50
