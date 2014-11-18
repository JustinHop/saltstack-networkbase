{% from "services/salt/package-map.jinja" import pkgs with context %}

salt-master:
  pkg.installed:
    - name: {{ pkgs['salt-master'] }}
  file.managed:
    - name: /etc/salt/master
    - template: jinja
    - source: salt://services/salt/files/master
  service.running:
    - enable: True
    - watch:
      - pkg: salt-minion
      - file: salt-master
