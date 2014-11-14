#
#   OpenSSL Base Config
#
openssh-client:
  pkg.installed:
    - names:
      - openssh-client
      - openssh-blacklist
      - openssh-blacklist-extra

/etc/ssh/ssh_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://services/openssh/files/ssh_config

/etc/ssh/ssh_known_hosts:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://services/openssh/files/ssh_known_hosts

