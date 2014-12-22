#
#   services/newrelic/npi.sls
#   for java based npi plugins in newrelic
#

openjdk-7-jre-headless:
  pkg:
    - installed

npi-download:
  cmd.script:
    - source: salt://services/newrelic/scripts/download-npi.sh
    - user: root
    - group: root
    - cwd: /root
    - require:
      - pkg: openjdk-7-jre-headless
    - creates:
      - /opt/newrelic

