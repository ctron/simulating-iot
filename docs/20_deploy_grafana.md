# Deploy Grafana

In order to peek into the metrics data of OpenShift and the telemtry data
from Kapua, we will use Grafana. For this we will install a Grafana image
which is already prepared to work with hawkular, the OpenShift metrics backend.

We will also re-use this query the Elasticsearch data recored by Kapua.

## Performing the deployment

From the root of the repository run:

    ./scripts/deploy-grafana.sh

## Configuring Grafana

Navigate to http://hawkular-grafana-grafana.192.168.42.47.nip.io and login in
using the credentials `admin` : `admin`.

Create a new datasource with the parameters printed out by the `deploy-grafana.sh`
script.

**Note:** The authorization token has to be refreshed every 24 hours as we are using a
session token for simplicity.

Import the file `config/grafana/oveview.json` as a new dashboard.
