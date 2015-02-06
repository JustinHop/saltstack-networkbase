#
#   services/nginx/init.sls
#   base config for nginx, rest handled with github formula
#

include:
  - nginx/ng
  - crowdrise/ssl

/etc/nginx/htpasswd-showcase:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - contents: |
        crowdrise:$apr1$TgiH7/c9$16SygFXa4gmzsNdHnR/Gq/
        monitoring:$apr1$x.0UL7ik$7/A/p5vIAqPcHsem2/UM.0

/etc/nginx/htpasswd-dev:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - contents: |
        crowdrise:$apr1$bGpmtRQ2$Z1x21c8f.QTCSMSD.vvBb1
        monitoring:$apr1$x.0UL7ik$7/A/p5vIAqPcHsem2/UM.0

/etc/nginx/htpasswd-square:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - contents: |
        square:$apr1$wviczMvi$Mj.pXVKpJQxULQHMpc3qY0
        crowdrise:$apr1$TgiH7/c9$16SygFXa4gmzsNdHnR/Gq/
        monitoring:$apr1$x.0UL7ik$7/A/p5vIAqPcHsem2/UM.0

/etc/nginx/htpasswd-hp2015:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - contents: |
        huffpost:$apr1$L7uYgSRj$.aLFkt5gKGGi1hFAHGwjv/
        crowdrise:$apr1$TgiH7/c9$16SygFXa4gmzsNdHnR/Gq/
        monitoring:$apr1$x.0UL7ik$7/A/p5vIAqPcHsem2/UM.0

nginx-config:
{% if salt['pillar.get']('nginx:repo:crowdrise') %}
  pkgrepo.managed:
    - ppa: crowdrise/nginx-builds
    - keyid: 75FC36CE
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - name: nginx-light
    - skip_verify: true
    - refresh: true
{% else %}
  pkg.installed:
    - name: {{ salt['pillar.get']('nginx:package', 'nginx-full') }}
{% endif %}

{% if salt['pillar.get']('nginx:repo:crowdrise') %}
/etc/nginx/naxsi_core.rules:
  file.managed:
    - user: root
    - group: root
    - source: salt://class/lb/files/naxsi_core.rules
{% else %}
echo > /etc/nginx/naxsi_core.rules:
  cmd.run:
    - user: root
    - group: root
{% endif %}

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

/var/log/nginx:
  file.directory:
    - user: www-data
    - group: syslog
    - mode: 775

/etc/logrotate.d/100-nginx:
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
    - source: salt://services/nginx/files/monitoring/nginx.yaml
    - user: root
    - group: root
    - makedirs: True
    - template: jinja

{%  for proto in salt['pillar.get']('monitoring:remote') %}
{%    for site in salt['pillar.get']('monitoring:remote')[proto] %}
/etc/rackspace-monitoring-agent.conf.d/remote-{{ proto }}-{{ site }}.yaml:
  file.managed:
    - source: salt://services/nginx/files/monitoring/remote.yaml
    - user: root
    - group: root
    - makedirs: True
    - template: jinja
    - defaults:
      proto: {{ proto }}
      site: {{ site }}
{%    endfor %}
{%  endfor %}

{%  for proto in salt['pillar.get']('monitoring:remotepw') %}
{%    for site in salt['pillar.get']('monitoring:remotepw')[proto] %}
/etc/rackspace-monitoring-agent.conf.d/remotepw-{{ proto }}-{{ site }}.yaml:
  file.managed:
    - source: salt://services/nginx/files/monitoring/remotepw.yaml
    - user: root
    - group: root
    - makedirs: True
    - template: jinja
    - defaults:
      proto: {{ proto }}
      site: {{ site }}
{%    endfor %}
{%  endfor %}

