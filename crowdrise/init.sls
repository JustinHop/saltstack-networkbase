#
#   crowdrise/init.sls
#   Includes for crowdrise
#

include:
  - base/hostsfile/resolv

/etc/rc.local:
  file.managed:
    - source: salt://crowdrise/files/rc.local
    - user: root
    - group: root

crowdrise-nopkg:
  pkg.removed:
    - pkgs: ['nano', 'resolvconf']

