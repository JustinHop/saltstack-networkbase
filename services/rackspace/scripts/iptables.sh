#!/bin/bash

STATEFILE=/etc/network/iptables
STATEDIR=/etc/network/iptables.d
CRSTATEFILE=/etc/network/iptables-crowdrise
FILELINE=""
CRENDLINE="Local-Loopback"

if [ "$(ls -A $STATEDIR)" ]; then
  FILELINE=$(find $STATEDIR -type f -exec cat {} \;)
fi

function gen_file(){
  if ! [ -f $STATEFILE ]; then
    exit 1
  fi
  if ! [ -f $CRSTATEFILE ]; then
    exit 1
  fi
}

gen_file

cat $CRSTATEFILE
iptables-save | sed -e "0,/$CRENDLINE/d" \
  | awk '/-A FORWARD -m comment --comment RackConnectChain-FORWARD/{ print "'${FILELINE}'"}1' \
  | tee ${STATEFILE}-test

