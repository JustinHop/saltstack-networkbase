include:
  - services/openssh

openssh-server:
  pkg:
    - installed

/etc/ssh/banner:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://services/openssh/files/banner
    - require:
      - pkg: openssh-server

/etc/ssh/authorized_keys:
  file.recurse:
    - source: salt://services/openssh/files/authorized_keys
    - user: root
    - group: root
    - file_mode: 644
    - dirmode: 755

generate-missing-hostkeys:
  cmd.run:
    - name: ssh-keygen -A

