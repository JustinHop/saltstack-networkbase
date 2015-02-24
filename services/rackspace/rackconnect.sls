#
#   services/rackspace/rackconnect.sls
#   FUCKING FIX RACKCONNECT!!!!!!!!!!!
#

/etc/network/iptables-crowdrise:
  file.blockreplace:
    - source: salt://services/rackspace/files/iptables
    - template: jinja
    - user: root
    - group: root
