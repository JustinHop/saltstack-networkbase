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

for CONF in charset  localized-error-pages  other-vhosts-access-log  security  serve-cgi-bin ; do
  a2enconf $CONF
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

for MOD in \
  access_compat \
  alias \
  auth_basic \
  authn_core \
  authn_file \
  authz_core \
  authz_host \
  authz_user \
  autoindex \
  proxy \
  proxy_connect \
  proxy_http \
  rewrite \
  deflate \
  dir \
  ssl \
  env \
  filter \
  headers \
  mime \
  mpm_prefork \
  negotiation \
  php5 \
  setenvif \
  status ; do
  a2enmod $MOD
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

for SITE in \
  010-http-crowdrise.com \
  100-https-crowdrise.com \
  900-http-localhost-monitoring ; do
  a2ensite $SITE
done

if [ $RESTART==1 ]; then
  service apache2 restart
fi
