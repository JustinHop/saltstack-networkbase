
syslog-ng:
  pkg.installed:
    - names:
      - syslog-ng
#  service.running:
#    - require:
#      - pkg: syslog-ng
#    - restart: True
#    - watch:
#      - file: /etc/syslog-ng/syslog-ng.conf
#      - file: /etc/syslog-ng/conf.d/*
#      - pkg: syslog-ng

/var/lib/syslog-ng:
  file.directory:
    - mode: 755
    - user: logger
    - group: logger

/etc/tmpfiles.d/syslog-ng.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://syslog-ng/files/systemd/tmpfile.conf
    - require:
      - pkg: systemd

/etc/systemd/system/syslog-ng.service:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://syslog-ng/files/systemd/syslog-ng.service
    - require:
      - pkg: systemd

/etc/systemd/system/multi-user.target.wants/syslog-ng.service:
  file.symlink:
    - target: /etc/systemd/system/syslog-ng.service
    - require:
      - pkg: systemd
