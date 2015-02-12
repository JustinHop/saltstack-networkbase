{% from "services/rsyslog/map.jinja" import rsyslog with context %}

package_{{ rsyslog.package }}:
  pkg:
    - name: {{ rsyslog.package }}
    - installed

rsyslog-relp:
  pkg:
    - installed

/etc/logrotate.d/rsyslog:
  file.managed:
    - user: syslog
    - group: adm
    - mode: 775
    - makedirs: True
    - template: jinja
    - source: salt://services/rsyslog/files/logrotate.conf

/var/log/upstart:
  file.directory:
    - user: syslog
    - group: adm
    - mode: 775
    - makedirs: True

/home/syslog:
  file.symlink:
    - target: /var/log
    - force_symlinks: true
    - force: true

chown -R syslog /var/log:
  cmd.run:
    - user: root
    - group: root

service_{{ rsyslog.service }}:
  service.running:
    - name: {{ rsyslog.service }}
    - enable: True
    - require:
      - pkg: package_{{ rsyslog.package }}
    - watch:
      - file: config_{{ rsyslog.config }}

config_{{ rsyslog.config }}:
  file.managed:
    - name: /etc/rsyslog.conf
    - template: jinja
    - source: salt://services/rsyslog/files/rsyslog.conf.jinja
    - context:
      config: {{ salt['pillar.get']('rsyslog', {}) }}

/etc/rsyslog.d/30-omrelp.conf:
  file.managed:
    - source: salt://services/rsyslog/files/rsyslog.d/30-omrelp.conf
    - user: root
    - group: root
    - template: jinja


