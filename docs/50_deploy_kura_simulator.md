# Deploy Kura Simulator

From the root of the repository run:

    ./scripts/deploy-kura-simulator.sh

This creates a new instance of the Kura simulator and configures
it to use the configuration from `config/simulator1.json`, which
creates a set of sine curves as data.

## Checking for data

* Log in to Kapua
* Switch to "data"
* Query for data of `app1`


## Visualizing data with Grafana

Add a new datasource to grafana

* Name: `kapua`
* Type: Elasticsearch
* URL: http://elasticsearch-eclipse-kapua.192.168.12.34.nip.io
* Index Name: 1-GGGG-WW
