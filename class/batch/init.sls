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

