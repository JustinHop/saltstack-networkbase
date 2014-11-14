
logrotate:
  pkg:
    - installed

/etc/logrotate.conf:
  file.managed:
    - source: salt://base/full/logrotate/files/logrotate.conf
    - user: root
    - group: root
    - mode: 644

