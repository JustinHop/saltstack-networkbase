
logrotate:
  pkg:
    - installed

/etc/logrotate.conf:
  file.managed:
    - source: salt://services/logrotate/files/logrotate.conf
    - user: root
    - group: root
    - mode: 644

