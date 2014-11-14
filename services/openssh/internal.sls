include:
  - services/openssh/server

/etc/ssh/sshd_config:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://services/openssh/files/sshd_config.internal
    - require:
      - pkg: openssh-server

