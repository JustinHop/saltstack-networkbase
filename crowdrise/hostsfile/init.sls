#
#   crowdrise/hostsfile/init.sls
#   hostfile openstack style
#

include:
  - crowdrise/hostsfile/hostname
  - crowdrise/hostsfile/resolv

/etc/hosts:
  file.managed:
    - source: salt://crowdrise/hostsfile/files/hosts
    - template: jinja
    - user: root
