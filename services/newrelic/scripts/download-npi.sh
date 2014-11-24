#!/bin/bash

export LICENSE_KEY=847f9a3986c314777e97afe8171bb1d013fe4dff
export PREFIX=/opt/newrelic-npi

if [ -d /opt/newrelic-npi ]; then
  echo Exists. Exiting
  exit 0
fi

cd
wget https://download.newrelic.com/npi/release/install-npi-linux-debian-x64.sh

chmod +x install-npi-linux-debian-x64.sh

./install-npi-linux-debian-x64.sh -u -l $LICENSE_KEY
