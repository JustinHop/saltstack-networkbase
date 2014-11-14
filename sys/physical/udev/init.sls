#
#   udev files for physical systems
#   sys/phy/udev/init.sls
#

udevd-entries:
  file.recurse:
    - name: /etc/udev/rules.d
    - source: salt://sys/phy/udev/files/rules.d
    - user: root
    - group: root
    - file_mode: 644
  
