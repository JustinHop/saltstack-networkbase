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
