#
#   services/apache/trusty.sls
#   Apache config for ubuntu 14.04
#

/etc/apache2:
  file.recurse:
    - source: salt://services/apache/files/{{ grains['oscodename'] }}/{{ grains['cluster'] }}/apache2
    - dir_mode: 755
    - file_mode: 644
    - template: jinja
    - include_empty: true
    - keep_symlinks: true

/etc/php5:
  file.recurse:
    - source: salt://services/apache/files/{{ grains['oscodename'] }}/{{ grains['cluster'] }}/php5
    - dir_mode: 755
    - file_mode: 644
    - template: jinja
    - include_empty: true
    - keep_symlinks: true

php5enmod newrelic:
  cmd.run:
    - user: root
    - group: root

fix-apache-config-trusty:
  cmd.script:
    - source: salt://services/apache/scripts/fixit.sh
    - user: root
    - group: root
    - cwd: /root


/var/www/trunk/content/.htaccess:
  file.managed:
    - source: salt://services/apache/files/htaccess
    - user: root
    - group: root
    - mode: 644

trusty-packages:
  pkg.installed:
    - pkgs:
      - libapache2-mod-php5
      - newrelic-php5
      - libgd3
      - libjbig0
      - libtiff5
      - libvpx1
      - libxpm4
      - php5-gd

