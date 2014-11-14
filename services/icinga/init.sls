#
#   Icinga Nagios Monitor Service
#   services/icinga/init.sls
#

icinga:
  pkg.installed:
    - names:
      - icinga
      - nagios-plugins
      - nagios-plugins-contrib
      - check-mk-server
      - check-mk-livestatus
      - check-mk-multisite
      - check-mk-config-icinga
      - check-mk-doc
      - icinga-idoutils
      - icinga-web
      - icinga-web-pnp
      - mysql-server

icingca-/etc:
  file.recurse:
    - name: /etc
    - source: salt://services/icinga/files
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755

/etc/icinga/resource.cfg:
  file.managed:
    - mode: 640

/etc/icinga/apache2.conf:
  file.managed:
    - mode: 640
