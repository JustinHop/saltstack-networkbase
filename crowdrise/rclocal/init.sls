#
#   crowdrise/rclocal/init.sls
#   Includes for crowdrise
#

/etc/rc.local:
  file.managed:
    - source: salt://crowdrise/rclocal/files/rc.local
    - user: root
    - group: root

crowdrise-nopkg:
  pkg.removed:
    - pkgs: ['nano', 'resolvconf']

