#!/bin/bash

USER={{ salt['pillar.get']('mysql:user', 'user') }}
PASS={{ salt['pillar.get']('mysql:password', 'password') }}
HOST={{ salt['pillar.get']('mysql:slave', 'slave') }}
DB=base

PINGS_BAD_SQL='SELECT COUNT(*) FROM `wepay_pings` WHERE dequeued is null;'
TIPS_BAD_SQL='SELECT COUNT(*) FROM `wepay_donation_tips` WHERE dequeued is null;'

PINGS_TOTAL_SQL='SELECT COUNT(*) FROM `wepay_pings` WHERE dequeued is not null;'
TIPS_TOTAL_SQL='SELECT COUNT(*) FROM `wepay_donation_tips` WHERE dequeued is not null;'

PINGS_BAD=$(echo "$PINGS_BAD_SQL" | mysql -u$USER -p$PASS -h$HOST $DB | tail -n 1)
TIPS_BAD=$(echo "$TIPS_BAD_SQL" | mysql -u$USER -p$PASS -h$HOST $DB | tail -n 1)

PINGS_TOTAL=$(echo "$PINGS_TOTAL_SQL" | mysql -u$USER -p$PASS -h$HOST $DB | tail -n 1)
TIPS_TOTAL=$(echo "$TIPS_TOTAL_SQL" | mysql -u$USER -p$PASS -h$HOST $DB | tail -n 1)

cat <<EOF
metric wepay_pings_total uint64 $PINGS_TOTAL
metric wepay_tips_total uint64 $TIPS_TOTAL
metric wepay_pings_unprocessed uint64 $PINGS_BAD
metric wepay_tips_unprocessed uint64 $TIPS_BAD
status Unprocessed: pings $PINGS_BAD, tips $TIPS_BAD
EOF
