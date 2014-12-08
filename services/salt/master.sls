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
    - require:
      - pkg: python-pygit2
    - watch:
      - pkg: salt-minion
      - file: salt-master

dennis-python-repo:
  pkgrepo.managed:
    - humanname: Dennis Kaarsemaker Python Modules
    - name: ppa:dennis/python
    - dist: {{ grains['oscodename'] }}
    - require_in:
      - service: salt-master
      - pkg: python-pygit2

python-pygit2:
  pkg.installed

npm:
  pkg.installed

gitlab-deploy-salt:
  npm.installed:
    - require:
      - pkg: npm



