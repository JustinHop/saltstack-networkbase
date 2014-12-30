#
#   services/mysql/newrelic.sls
#   newrelic monitoring for mysql
#
/opt/newrelic-npi:
  file.directory:
    - makedirs: True
    - user: newrelic
    - group: newrelic

mysql-npi-install:
  cmd.script:
    - source: salt://services/mysql/scripts/npi-install.sh
    - cwd: /opt/newrelic-npi
    - require:
      - cmd: npi-download
      - file: /opt/newrelic-npi

/opt/newrelic-npi/plugins/com.newrelic.plugins.mysql.instance/newrelic_mysql_plugin-2.0.0/config/newrelic.json:
  file.managed:
    - makedirs: False
    - user: root
    - group: root
    - template: jinja
    - source: salt://services/mysql/files/newrelic.json
    - require:
      - cmd: mysql-npi-install

/opt/newrelic-npi/plugins/com.newrelic.plugins.mysql.instance/newrelic_mysql_plugin-2.0.0/config/plugin.json:
  file.managed:
    - makedirs: False
    - user: root
    - group: root
    - template: jinja
    - source: salt://services/mysql/files/plugin.json
    - require:
      - cmd: mysql-npi-install

newrelic_plugin_com.newrelic.plugins.mysql.instance:
  service.running:
    - watch:
      - file: /opt/newrelic-npi/plugins/com.newrelic.plugins.mysql.instance/newrelic_mysql_plugin-2.0.0/config/plugin.json
    - requires:
      - file: /opt/newrelic-npi/plugins/com.newrelic.plugins.mysql.instance/newrelic_mysql_plugin-2.0.0/config/plugin.json

