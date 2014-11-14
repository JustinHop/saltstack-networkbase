#
#   Linux Containers Service
#   services/lxc/init.sls
#

lxc:
  pkg.installed:
    - names:
      - lxc
      - debootstrap
      - bridge-utils
      - lxctl

/etc/lxc/default.conf:
  file.managed:
    - source: salt://services/lxc/files/default.conf
    - user: root
    - group: root
    - mode: 644

/etc/lxc/lxc.conf:
  file.managed:
    - source: salt://services/lxc/files/lxc.conf
    - user: root
    - group: root
    - mode: 644
