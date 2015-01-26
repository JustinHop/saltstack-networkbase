#
#   services/apache/monitoring.sls
#   rackspace monitoring of apache stats
#

/etc/apache2/sites-available/900-http-localhost-monitoring.conf:
  file.managed:
    - source: salt://services/apache/files/monitoring/status.conf
    - user: root
    - group: root
    - template: jinja
    - makedirs: true
    - mode: 644

a2ensite 900-http-localhost-monitoring.conf:
  cmd.run:
    - user: root
    - group: root
    - template: jinja
    - require:
      - file: /etc/apache2/sites-available/900-http-localhost-monitoring.conf

/etc/rackspace-monitoring-agent.conf.d/apache.yaml:
  file.managed:
    - source: salt://services/apache/files/monitoring/apache.yaml
    - user: root
    - group: root
    - makedirs: true
    - mode: 755

