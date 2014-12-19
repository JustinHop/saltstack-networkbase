#!/bin/bash
set -x
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


RFC1918='^(10|192\.168|172\.(1[6-9]|2[0-9]|3[01]))\.'

reg_addr () {
  local _ADDR=$1
  local _HOST="$2${HOST}"
  local _RESOLVED=$(dig $_ADDR +short)
  local _UPDATE=
  if [ $_RESOLVED ]; then
    UPDATE="-U"
  fi

  /usr/local/rsdns/rsdns-a.sh \
    -u $RSUSER \
    -a $RSAPI \
    -d $RSDOM \
    -n $_HOST \
    -t $RSTTL \
    -i $_ADDR \
    $_UPDATE
}

for ADDR in $(hostname -I | tr ' ' "\n" | grep -v ':' ) ; do
  echo $ADDR
  if echo $ADDR | grep -P "$RFC1918" ; then
    echo $ADDR PRIVATE
    PRIVATE=$ADDR
    reg_addr $ADDR
  else
    echo $ADDR PUBLIC
    PUBLIC=$ADDR
    reg_addr $ADDR ext.
  fi
done



#if [ -f /usr/bin/rackspace-monitoring-agent ]; then
#  if ! [ -f /etc/rackspace-monitoring-agent.cfg ]; then
#    /usr/bin/rackspace-monitoring-agent --setup --username $RSUSER --apikey $RSAPI
#    service rackspace-monitoring-agent start
#  fi
#fi
