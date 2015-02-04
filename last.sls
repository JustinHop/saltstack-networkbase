#
#   last.sls
#   mark last highstate run
#

date >> /var/cache/salt/minion/highstate.last:
  cmd.run:
    - user: root
    - group: root
    - order: last

#chmod 644 /etc/ssh/authorized_keys/*:
#  cmd.run:
#    - user: root
#    - group: root
