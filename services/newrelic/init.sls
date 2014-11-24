#
#   services/newrelic/init.sls
#   Monitoring for newrelic 
#


newrelic:
  pkg.installed:
    - pkgs:
      - newrelic-sysmond
      - newrelic-daemon
      - python-pip
  module.run:
    - name: pip.install
    - pkgs:
      - newrelic-plugin-agent
    - requires:
      - pkg: python-pip

/etc/newrelic:
  file.recurse:
    - source: salt://services/newrelic/files/newrelic
    - makedirs: True
    - user: root
    - group: root
    - file_mode: 0644
    - dir_mode: 0755
    - template: jinja

/etc/init.d/newrelic-plugin-agent:
  file.managed:
    - source: salt://services/newrelic/files/init.d/newrelic-plugin-agent
    - user: root
    - group: root
    - mode: 0755
    - template: jinja

newrelic-plugin-agent:
  service.running:
    - require:
      - file: /etc/init.d/newrelic-plugin-agent

newrelic-sysmond:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: newrelic-sysmond

newrelic-daemon:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: newrelic-daemon

nrsysmond-config --set license_key=847f9a3986c314777e97afe8171bb1d013fe4dff ; service newrelic-sysmond start:
  cmd.run:
    - onfail:
      - service: newrelic-sysmond

