#!/bin/bash

STATEFILE=/etc/network/iptables
STATEDIR=/etc/network/iptables.d
STATEFILEHEAD=/etc/network/iptables-head
FILEUUID=bd735451-8b40-4ab6-99e1-b9848b9418cf
FILELINE="# FILES $FILEUUID"
FILELINES=""
ENDLINE="Local-Loopback"

if [ "$(ls -A $STATEDIR)" ]; then
  FILELINES=$(find $STATEDIR -type f -exec cat {} \;)
fi

function gen_file(){
  if ! [ -f $STATEFILE ]; then
    exit 1
  fi
  if ! [ -f $STATEFILEHEAD ]; then
    exit 1
  fi
}

gen_file

( cat $STATEFILEHEAD | while read LINE ; do
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
  done; iptables-save | sed -e "0,/$ENDLINE/d" ) \
  | tee ${STATEFILE}
