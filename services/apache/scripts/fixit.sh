#!/bin/bash


RESTART=0
mkdir ~/backup

#
# Configs
#

for CONF in /etc/apache2/conf-enabled/* ; do
  if [ -h $CONF ]; then
    echo $CONF is good
  else
    RESTART=1
    mv -v $CONF ~/backup
    a2enconf $(basename $CONF .conf)
  fi
done

#
# Mods
#

for MOD in /etc/apache2/mods-enabled/* ; do
  if [ -h $MOD ]; then
    echo $MOD is good
  else
    RESTART=1
    mv -v $MOD ~/backup
    a2enmod $(basename $MOD .conf)
  fi
done

#
# Sites
#

for SITE in /etc/apache2/sites-enabled/* ; do
  if [ -h $SITE ]; then
    echo $SITE is good
  else
    RESTART=1
    mv -v $SITE ~/backup
    a2ensite $(basename $SITE .conf)
  fi
done


if [ $RESTART==1 ]; then
  service apache2 restart
fi
