#
#   Sup Class
#   class/sup/init.sls
#

include:
  - base/min/ca
  - base/min/profile
  - base/full/python
  - base/full/systemd
  - services/openssh/internal
  - services/lxc
  - os/Debian/backports

/etc/apt/preferences.d:
  file.recurse:
    - source: salt://class/sup/files/apt/preferences.d
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755

/etc/default/grub:
  file.managed:
    - source: salt://class/sup/files/default/grub
    - user: root
    - group: root
    - mode: 644

