{% from "services/salt/package-map.jinja" import pkgs with context %}

salt-master:
  pkg.installed:
    - pkgs: 
      - {{ pkgs['salt-master'] }}
      - python-pygit2
        - require
  pkgrepo.managed:
    - humanname: Dennis Kaarsemaker Python Modules
    - name: ppa:dennis/python
    - dist: {{ grains['oscodename'] }}
    - require_in:
      - service: salt-master
      - pkg: python-pygit2
  file.managed:
    - name: /etc/salt/master
    - template: jinja
    - source: salt://services/salt/files/master
  service.running:
    - enable: True
    - watch:
      - pkg: salt-minion
      - file: salt-master

npm:
  pkg.installed

gitlab-deploy-salt:
  npm.installed:
    - require:
      - pkg: npm



