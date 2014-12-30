#
#   services/mysql/common.sls
#   where percona/mariadb/percona base stuff goes
#

echo mysql > /etc/product:
  cmd.run:
    - user: root

include:
  - services/newrelic
  - services/newrelic/npi
  - services/mysql/newrelic


/etc/rackspace-monitoring-agent.conf.d/mysql.yaml:
  file.managed:
    - source: salt://services/mysql/files/monitoring/mysql-slave.yaml
    - user: root
    - group: root
    - template: jinja
    - defaults:
      - target_username: {{ salt['pillar.get']('mysqlmon:user', 'user') }}
      - target_password: {{ salt['pillar.get']('mysqlmon:pass', 'pass') }}
