#
#   crowdrise/init.sls
#   Includes for crowdrise
#

include:
  - basehostsfile/resolv

/etc/rc.local:
  file.managed:
    - source: salt://crowdrise/files/rc.local
    - user: root
    - group: root

crowdrise-nopkg:
  pkg.removed:
    - pkgs: ['nano', 'resolvconf']

