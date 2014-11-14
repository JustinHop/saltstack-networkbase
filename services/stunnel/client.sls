
include:
  - stunnel

/etc/stunnel/syslog-client.conf:
  file.managed:
    - source: salt://stunnel/files/syslog-client.conf
    - user: root
    - group: root
    - mode: 644
