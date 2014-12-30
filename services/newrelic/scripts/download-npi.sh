#!/bin/bash

export LICENSE_KEY=847f9a3986c314777e97afe8171bb1d013fe4dff
export PREFIX=/opt/newrelic-npi

if [ -f /opt/newrelic-npi/npi ]; then
  echo Exists. Exiting
  exit 0
fi

cd /opt
curl -L https://download.newrelic.com/npi/release/install-npi-linux-debian-x64.sh | sh -s -- -u -l $LICENSE_KEY
