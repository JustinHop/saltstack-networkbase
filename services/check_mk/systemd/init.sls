
check_mk.socket:
  file.managed:
    - name: /etc/systemd/system/check_mk.socket
    - source: salt://services/check_mk/systemd/files/check_mk.socket
    - user: root
    - group: root
    - mode: 644

check_mk.socket.target:
  file.symlink:
    - name: /etc/systemd/system/sockets.target.wants/check_mk.socket
    - target: /etc/systemd/system/check_mk.socket

/etc/systemd/system/check_mk@.service:
  file.managed:
    - source: salt://services/check_mk/systemd/files/check_mk@.service
    - user: root
    - group: root
    - mode: 644

/etc/systemd/system/sockets.target.wants/check_mk@.service:
  file.symlink:
    - target: /etc/systemd/system/check_mk@.service

