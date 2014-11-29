#
#   last.sls
#   Cheap workarounds
#

chmod 644 /etc/ssh/authorized_keys/*:
  cmd.run:
    - user: root
    - group: root
