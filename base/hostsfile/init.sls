#
#   base/hostsfile/init.sls
#   hostfile openstack style
#

include:
  - base/hostsfile/hostname
  - base/hostsfile/resolv

/etc/hosts:
  file.managed:
    - source: salt://base/hostsfile/files/hosts
    - template: jinja
    - user: root
