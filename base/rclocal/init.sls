#
#   base/rclocal/init.sls
#   Includes for base
#

/etc/rc.local:
  file.managed:
    - source: salt://base/rclocal/files/rc.local
    - user: root
    - group: root

base-nopkg:
  pkg.removed:
    - pkgs: ['nano', 'resolvconf']

