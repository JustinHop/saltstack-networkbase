#!/bin/bash

exec 2> /dev/null

USER={{ salt['pillar.get']('mysql:user', 'user') }}
PASS={{ salt['pillar.get']('mysql:password', 'password') }}
HOST={{ salt['pillar.get']('mysql:slave', 'slave') }}
DB=crowdrise
MYSQL="mysql -u$USER -p$PASS -h$HOST $DB"

CHECK1='(( $ROWS > 1000000 ))'
if [ $1 ]; then
  CHECK1='(( $ROWS > $1 ))'
  if [ $2 ]; then
    if ! [ "$2" == "0" ]; then
      CHECK2='&&(( $ROWS < $2 ))'
    fi
  fi
fi

echo "status ok connected"
for TABLE in $(echo "show tables;" | $MYSQL); do
  ROWS=$(printf 'SELECT COUNT(*) FROM `%s`;\n' "$TABLE" | $MYSQL | tail -n 1 )
  if eval $CHECK1 $CHECK2 ; then
    echo "metric crowdrisedb_${TABLE}_rows uint64 $ROWS"
  fi
done

