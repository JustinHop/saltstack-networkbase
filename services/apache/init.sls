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
  - services/apache/{{ grains['oscodename'] }}
{%- if grains['cluster'] == "prod" %}
  - services/apache/cron
{% endif %}

#/etc/apache2:
#  file.recurse:
#    - source: salt://services/apache/files/{{ grains['oscodename'] }}/{{ grains['cluster'] }}/apache2
#    - dir_mode: 755
#    - file_mode: 644
#    - template: jinja
#    - include_empty: true

#php5-fpm:
#  pkg:
#    - installed
#  service:
#    - running

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

www.crowdrise.com:
  git.latest:
    - name: git@gitlab.crowdrise.com:crowdrise/codeigniter-app.git
    - user: crowdrise
    - group: www-data
    - target: /var/www/vhosts/www.crowdrise.com
    - identity: /home/crowdrise/.ssh/id_rsa
    - require:
      - pkg: git
    - unless:
      - 'test \! -f /var/www/vhosts/www.crowdrise.com/htdocs/content/robots.txt'

/var/www/vhosts/www.crowdrise.com/htdocs:
  file.symlink:
    - target: /var/www/trunk

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
