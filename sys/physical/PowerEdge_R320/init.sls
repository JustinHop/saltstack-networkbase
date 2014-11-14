#
#   Dell PowerEdge R320 Systems
#   sys/phy/PowerEdge R320/init.sls
#

/etc/modprobe.d/tg3.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 640
    - source: salt://sys/phy/PowerEdge_R320/files/modprobe.d/tg3.conf
