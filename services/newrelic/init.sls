#
#   services/newrelic/init.sls
#   Monitoring for newrelic 
#


newrelic-mon-python:
  pkg.installed:
    - name: python-pip
  module.run:
    - name: pip.install
    - pkgs:
      - newrelic-plugin-agent
    - requires:
      - pkg: python-pip


/etc/newrelic:
  file.recurse:
    - source://services/newrelic/files
    - makedirs: True
    - user: root
    - group: root
    - file_mode: 0644
    - dir_mode: 0755
    - template: jinja
