#
#   SSH Guard Config
#   services/sshguard/init.sls
#

sshguard:
  pkg.installed: []
  service.running:
    - require:
      - pkg: sshguard
      - file: /etc/default/sshguard

/etc/default/sshguard:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://services/sshguard/files/default/sshguard

/etc/sshguard/whitelist:
  file.managed:
    - user: root
    - group: root
    - template: jinja
    - mode: 644
    - source: salt://services/sshguard/files/whitelist
    - defaults:
      sshguard_whitelist: www.justinhoppensteadt.com
