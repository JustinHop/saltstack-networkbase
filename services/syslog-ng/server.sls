
include:
  - syslog-ng

/etc/syslog-ng/conf.d/00server.conf:
  file.managed:
    - source: salt://syslog-ng/files/00server.conf
    - user: root
    - group: root
    - mode: 644

/etc/logrotate.d/syslog-ng:
  file.managed:
    - source: salt://syslog-ng/files/logrotate-syslog
    - user: root
    - group: root
    - mode: 644
