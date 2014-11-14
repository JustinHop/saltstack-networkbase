
include:
  - services/openssh

ssh-sysv:
  service.running:
    - enable: True
    - name: ssh
    - require:
      - pkg: openssh-client
      - pkg: openssh-server
      - file: /etc/ssh/banner
      - file: /etc/ssh/sshd_config
    - watch:
      - file: /etc/ssh/sshd_config
      - pkg: openssh-server


