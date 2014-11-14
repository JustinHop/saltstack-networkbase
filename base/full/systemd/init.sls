
systemd-add:
  pkg.installed:
    - force: true
    - names:
      - systemd
      - python-dbus
      #- systemd-sysv

/etc/systemd/system/sockets.target.wants:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - requires:
      - pkg:
        - systemd

#systemd-rem:
#  pkg.removed:
#    - force: true
#    - names:
#      - sysvinit

