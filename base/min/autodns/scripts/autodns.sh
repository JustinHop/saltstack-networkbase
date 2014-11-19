#!/bin/bash
#
# autodns.sh
# Checks if internal dns is set up for host then adds it if necessary
#


HOST=$(hostname)

RSUSER="crowd246"
RSID="926406"
RSAPI="970c61c73891b471e0dd45f61051ed29"
RSDOM="crowdrise.io"
RSTTL=300
RSPATH=/usr/local/rsdns

RESOLVED=$(dig $HOST +short)

if [ $RESOLVED ]; then
  /usr/local/rsdns/rsdns-a.sh \
    -u $RSUSER \
    -a $RSAPI \
    -d $RSDOM \
    -n $HOST \
    -t $RSTTL \
    -i $(hostname -I | awk '{ print $1 }') \
    -U
else
  /usr/local/rsdns/rsdns-a.sh \
    -u $RSUSER \
    -a $RSAPI \
    -d $RSDOM \
    -n $HOST \
    -t $RSTTL \
    -i $(hostname -I | awk '{ print $1 }')
fi

