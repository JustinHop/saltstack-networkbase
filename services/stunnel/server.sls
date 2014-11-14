
include:
  - stunnel

/etc/stunnel/syslog.conf:
  file.managed:
    - source: salt://stunnel/files/syslog.conf
    - user: root
    - group: root
    - mode: 644
