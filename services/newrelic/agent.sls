#
#   services/newrelic/agent.sls
#   split out roles for newrelic agent

include:
  - services/newrelic

newrelic-plugin-agent:
  service.running:
    - require:
      - file: /etc/init.d/newrelic-plugin-agent
    - watch:
      - file: /etc/init.d/newrelic-plugin-agent
  module.run:
    - name: pip.install
    - pkgs:
      - newrelic-plugin-agent

/etc/init.d/newrelic-plugin-agent:
  file.managed:
    - source: salt://services/newrelic/files/init.d/newrelic-plugin-agent
    - user: root
    - group: root
    - mode: 0755
    - template: jinja

