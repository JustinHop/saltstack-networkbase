#!/bin/bash

STATEFILE=/etc/network/iptables
STATEDIR=/etc/network/iptables.d
CRSTATEFILE=/etc/network/iptables-crowdrise
FILEUUID=20557911-7a00-40e4-a3d5-f75679d71855
FILELINE="# FILES 20557911-7a00-40e4-a3d5-f75679d71855"
FILELINES=""
CRENDLINE="Local-Loopback"

if [ "$(ls -A $STATEDIR)" ]; then
  FILELINES=$(find $STATEDIR -type f -exec cat {} \;)
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

( cat $CRSTATEFILE | while read LINE ; do
    case "$LINE" in
      $FILELINE)
        if [ "$(ls -A $STATEDIR)" ]; then
          find "$STATEDIR" -type f -exec cat {} \;
        else
          echo "$FILELINE"
        fi
        ;;
      *)
        echo "$LINE"
        ;;
    esac
  done; iptables-save | sed -e "0,/$CRENDLINE/d" ) \
  | tee ${STATEFILE}
