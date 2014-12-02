#!/bin/bash

CERT=/etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt
CHAIN=/etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt.ca
FULL=/etc/pki/tls/certs/2016-wildcard.crowdrise.com.certchain
DIR=/etc/pki/tls/certs

if ! [ -f $CERT ]; then
  echo NO CERT
  exit 1
fi

if ! [ -f $CHAIN ]; then
  echo NO CHAIN
  exit 1
fi

if ! [ -d $DIR ]; then
  echo NO DIR
  exit 1
fi

cd $DIR
cat $CERT $CHAIN | tee $FULL
