
include:
  - syslog-ng

syslog-ng-client:
  file.managed:
    - name: /etc/syslog-ng/conf.d/05client.conf
    - source: salt://syslog-ng/files/05client.conf
    - user: root
    - group: root
    - mode: 644
