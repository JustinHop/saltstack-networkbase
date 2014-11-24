#
#   services/varnish/newrelic.sls
#

varnish-npi-install:
  cmd.script:
    - source: salt://services/varnish/scripts/npi-install.sh
    - cwd: /opt/newrelic-npi
    - require:
      - cmd: npi-download

/opt/newrelic-npi/plugins/ar.com.3legs.newrelic.varnish/newrelic_3legs_plugin-2.0.0/config/plugin.json:
  file.managed:
    - makedirs: False
    - user: root
    - group: root
    - template: jinja
    - source: salt://services/varnish/files/plugin.json
    - require:
      - cmd: varnish-npi-install


newrelic_plugin_ar.com.3legs.newrelic.varnish:
  service.running:
    - watch:
      - file: /opt/newrelic-npi/plugins/ar.com.3legs.newrelic.varnish/newrelic_3legs_plugin-2.0.0/config/plugin.json
    - requires:
      - file: /opt/newrelic-npi/plugins/ar.com.3legs.newrelic.varnish/newrelic_3legs_plugin-2.0.0/config/plugin.json

