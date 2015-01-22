#
#   class/batch/init.sls
#   settings for batch php processing system
#

include:
  - class/http

/etc/cron.d/crowdrise:
  file.managed:
    - source: salt://class/batch/files/cron
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/etc/rackspace-monitoring-agent.conf.d/wepay.yaml:
  file.managed:
    - source: salt://class/batch/files/rackspace.yaml
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/usr/lib/rackspace-monitoring-agent/plugins/wepay.sh:
  file.managed:
    - source: salt://class/batch/files/wepay.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 755

