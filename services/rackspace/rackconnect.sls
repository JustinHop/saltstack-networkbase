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

reload-ip-tables:
  cmd.run:
    - name: |
      iptables-restore < /etc/network/iptables
    - user: root
    - group: root
    - requires:
      - cmd: run-iptables-stuffs
