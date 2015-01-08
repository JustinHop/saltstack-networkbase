#
#   services/rsyslog/server.sls
#   rsyslog server
#

rsyslog:
  service.running

/etc/rsyslog.d/50-imrelp.conf:
  file.managed:
    - source: salt://services/rsyslog/files/rsyslog.d/50-imrelp.conf
    - user: root
    - group: root
    - template: jinja
