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

run-iptables-stuffs:
  cmd.script:
    - source: salt://services/rackspace/scripts/iptables.sh
    - user: root
    - group: root
    - order: last
    - template: jinja
