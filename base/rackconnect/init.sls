#
#   base//rackconnect/init.sls
#   enable custom rules for rackconnect
#

touch /etc/rackconnect-allow-custom-iptables:
  cmd.run:
    - user: root

