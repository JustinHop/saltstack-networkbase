#
#   product/showcase/init.sls
#   put the apache configs for showcase here
#

#include:
#  - apache/debian_full
#  - apache/vhost_alias
#  - apache/php5


echo showcase > /etc/product:
  cmd.run:
    - user: root
