#
#   services/mysql/common.sls
#   where percona/mariadb/percona base stuff goes
#

echo mysql > /etc/product:
  cmd.run:
    - user: root

include:
  - services/mysql/newrelic
