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
      - php5
      - php5-apcu
      - php5-cli
      - php5-common
      - php5-curl
      - php5-mysqlnd
      - php5-gd

include:
  - services/apache/monitoring

/etc/apache2/confs-available:

{%  for PART in ["mods", "confs", "sites"] %}
{%    for BASE in salt['pillar.get']('apache', []) %}
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
{%    endfor %}
{%  endfor %}

{%      for ITEM in salt['pillar.get']('apache:' ~ BASE ~ ':mods', "" ) %}
a2enmod  {{ ITEM }}:
  cmd.run:
    - user: root
    - group: root
{%      endfor %}
{%      for ITEM in salt['pillar.get']('apache:' ~ BASE ~ ':confs', "" ) %}
a2enconf  {{ ITEM }}:
  cmd.run:
    - user: root
    - group: root
{%      endfor %}
{%      for ITEM in salt['pillar.get']('apache:' ~ BASE ~ ':sites', "" ) %}
a2ensite  {{ ITEM }}:
  cmd.run:
    - user: root
    - group: root
{%    endfor %}

git archive --format=tar --remote=git@gitlab.crowdrise.com:crowdrise/codeigniter-app.git master | tar --totals -xvmpf - -C /var/www/vhosts/www.crowdrise.com/htdocs:
  cmd.run:
    - user: crowdrise
    - group: crowdrise
    - require:
      - file: /var/www/vhosts/www.crowdrise.com/htdocs
    - creates: /var/www/vhosts/www.crowdrise.com/htdocs/application

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

/var/www/vhosts/www.crowdrise.com/htdocs:
  file.directory:
    - user: crowdrise
    - group: crowdrise
    - makedirs: true
    - mode: 775

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
