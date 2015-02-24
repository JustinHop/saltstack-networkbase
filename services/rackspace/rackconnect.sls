#
#   services/rackspace/rackconnect.sls
#   FUCKING FIX RACKCONNECT!!!!!!!!!!!
#

/etc/network/iptables-crowdrise:
  file.managed:
    - source: salt://services/rackspace/files/iptables
    - template: jinja
    - user: root
    - group: root

/etc/network/iptables.d:
  file.directory:
    - user: root
    - group: rackconnect
    - mode: 750

