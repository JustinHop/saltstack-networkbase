#
#   services/mysql/init.sls
#   stuff for mysql
#

echo mysql > /etc/product:
  cmd.run:
    - user: root
