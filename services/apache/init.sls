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
      - apache2.2-common
      - apache2.2-bin
      - php-apc
      - php5
      - php5-cli
      - php5-common
      - php5-curl
      - php5-mysql

#/etc/apache2:
#  file.recurse:
#    - source: salt://services/apache/files/{{ grains['oscodename'] }}/{{ grains['cluster'] }}/apache2
#    - dir_mode: 755
#    - file_mode: 644
#    - template: jinja
#    - include_empty: true

php5-fpm:
  pkg:
    - installed
  service:
    - running

