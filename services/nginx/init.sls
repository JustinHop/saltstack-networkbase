#
#   services/nginx/init.sls
#   base config for nginx, rest handled with github formula
#

nginx-config:
  pkgrepo.managed:
    - ppa: crowdrise/nginx-builds
    - keyid: 75FC36CE
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - name: nginx-light
    - refresh: true

openssl dhparam -out /etc/nginx/dhparam.pem 4096:
  cmd.run:
    - user: root
    - group: root
    - creates: /etc/nginx/dhparam.pem

/etc/nginx/include:
  file.managed:
    - user: root
    - group: root
    - source: salt://class/lb/files/include

/etc/nginx/naxsi.rules:
  file.managed:
    - user: root
    - group: root
    - source: salt://class/lb/files/naxsi.rules

/etc/nginx/naxsi_core.rules:
  file.managed:
    - user: root
    - group: root
    - source: salt://class/lb/files/naxsi_core.rules

/var/log/nginx:
  file.directory:
    - user: www-data
    - group: syslog
    - mode: 775

/etc/logrotate.d/nginx:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - source: salt://services/nginx/files/logrotate.conf

/etc/rsyslog.d/nginx.conf:
  file.managed:
    - source: salt://services/nginx/files/rsyslog.conf
    - user: root
    - group: root
    - makedirs: True

/etc/rackspace-monitoring-agent.conf.d/nginx.yaml:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - contents: |
      type        : agent.plugin
      label       : Nginx
      disabled    : false
      period      : 60
      timeout     : 30
      details     :
          file    : /usr/lib/rackspace-monitoring-agent/plugins/nginx_status_check.py
      alarms      :
          nginx:
              label                 : Nginx
              notification_plan_id  : npYJv7dn5N


