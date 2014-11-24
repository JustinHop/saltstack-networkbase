#!/bin/bash

if ! [ -d /opt/newrelic-npi ]; then
  echo "No NPI! Bailing!"
  exit 1
fi


cd /opt/newrelic-npi

if ./npi list | grep ar.com.3legs.newrelic.varnish ; then
  echo "looks installed, Bailing"
  exit 0
fi

./npi install ar.com.3legs.newrelic.varnish --yes --noedit
