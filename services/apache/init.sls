{% from "services/apache/map.jinja" import apache with context %}

apache:
  pkg:
    - installed
    - name: {{ apache.server }}
  service:
    - running
    - name: {{ apache.service }}
    - enable: True

apache-reload:
  module:
    - wait
    - name: service.reload
    - m_name: {{ apache.service }}

apache-restart:
  module:
    - wait
    - name: service.restart
    - m_name: {{ apache.service }}

cr-apache-pkgs:
  pkg.installed:
    - pkgs:
      - apache2
      - apache2-mpm-prefork
      - php-apc
      - php5
      - php5-cli
      - php5-common
      - php5-curl
      - php5-mysql

include:
  - services/apache/monitoring

{%  for PART in ["mods", "conf", "sites"] %}
/etc/apache2/{{ PART }}-available:
  file.recurse:
    - source: salt://services/apache/files/{{ PART }}-available
    - clean: True
    - user: root
    - group: root
    - template: jinja
mv /etc/apache2/{{ PART }}-enabled/* /root:
  cmd.run:
    - user: root
    - group: root
{%  endfor %}

{%  for PART in ["mod", "conf", "site"] %}
{%    for BASE in pillar['apache'] %}
{%      for ITEM in pillar['apache'][BASE][PART] %}
a2en{{ PART }} {{ ITEM }}:
  cmd.run:
    - user: root
    - group: root

{%      endfor %}
{%    endfor %}
{%  endfor %}


/etc/rsyslog.d/apache-crowdrise.conf:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - mode: 644
    - source: salt://services/apache/files/rsyslog.conf

/var/www/:
  file.directory:
    - user: www-data
    - mode: 755
    - makedirs: True

/var/www/vhosts/www.crowdrise.com:
  file.directory:
    - user: root
    - group: root
    - makedirs: true
    - mode: 755

/var/www/vhosts/www.crowdrise.com/htdocs/content/photos/bin1/original:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: true

/var/www/vhosts/www.crowdrise.com/htdocs/content/photos/original:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: true

/var/www/vhosts/www.crowdrise.com/htdocs/content/photos:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: true

/var/www/vhosts/www.crowdrise.com/htdocs/content/uploads:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: true

/var/www/vhosts/www.crowdrise.com/htdocs/content/reports:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: true
