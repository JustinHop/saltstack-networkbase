#
#   services/rackspace/rackconnect.sls
#   FUCKING FIX RACKCONNECT!!!!!!!!!!!
#

/etc/network/iptables:
  file.blockreplace:
    - marker_start: "#"
    - marker_end: "-A RS-RackConnect-INBOUND -i lo -m comment --comment Local-Loopback -j ACCEPT"
    - source: salt://services/rackspace/files/iptables
    - template: jinja
    - user: root
    - group: root
