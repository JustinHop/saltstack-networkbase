
include:
  - openssh

ssh-systemd:
  service.running:
    - enable: True
    - name: sshd@sockets.service
    - require:
      - pkg: openssh-client
      - pkg: openssh-server
      - file: /etc/ssh/banner
      - file: /etc/ssh/sshd_config
    - watch:
      - file: /etc/ssh/sshd_config
      - pkg: openssh-server

ssh-disable-sysv:
  cmd.run:
    - name: update-rc.d ssh disable

sshd.socket:
  file.managed:
    - name: /etc/systemd/system/sshd.socket
    - source: salt://services/openssh/systemd/sshd.socket
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: systemd

sshd.socket.target:
  file.symlink:
    - name: /etc/systemd/system/sockets.target.wants/sshd.socket
    - target: /etc/systemd/system/sshd.socket
    - require:
      - pkg: systemd

/etc/systemd/system/sshd@.service:
  file.managed:
    - source: salt://services/openssh/systemd/sshd@.service
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: systemd

/etc/systemd/system/sockets.target.wants/sshd@.service:
  file.symlink:
    - target: /etc/systemd/system/sshd@.service
    - require:
      - pkg: systemd

/etc/tmpfiles.d/sshd.conf:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - source: salt://services/openssh/systemd/tmpfile.conf
    - require:
      - pkg: systemd

