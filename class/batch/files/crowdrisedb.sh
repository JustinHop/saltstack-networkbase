#!/bin/bash

USER={{ salt['pillar.get']('mysql:user', 'user') }}
PASS={{ salt['pillar.get']('mysql:password', 'password') }}
HOST={{ salt['pillar.get']('mysql:slave', 'slave') }}
DB=crowdrise
MYSQL="mysql -u$USER -p$PASS -h$HOST $DB"

echo "status ok"
for TABLE in $(echo "show tables;" | $MYSQL); do
  ROWS=$(printf 'SELECT COUNT(*) FROM `%s`;\n' "$TABLE" | $MYSQL | tail -n 1 2> /dev/null)
  if [ $ROWS ]; then
    echo "metric crowdrisedb_${TABLE}_rows uint64 $ROWS"
  fi
done

