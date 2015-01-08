#
#   services/newrelic/init.sls
#   Monitoring for newrelic 
#

newrelic-monitoring-repo:
  pkgrepo.managed:
    - name: deb http://apt.newrelic.com/debian/ newrelic non-free
    - key_url: https://download.newrelic.com/548C16BF.gpg

newrelic:
  pkg.installed:
    - pkgs:
      - newrelic-sysmond
      - newrelic-daemon
    - requires:
      - pkgrepo: newrelic-monitoring-repo

/etc/newrelic:
  file.recurse:
    - source: salt://services/newrelic/files/newrelic
    - makedirs: True
    - user: root
    - group: root
    - file_mode: 0644
    - dir_mode: 0755
    - template: jinja

nrsysmond-config --set license_key=847f9a3986c314777e97afe8171bb1d013fe4dff:
  cmd.run:
    - require:
      - file: /etc/newrelic

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

