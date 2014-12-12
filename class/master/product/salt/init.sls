#
# class/master/product/salt/init.sls
# master.salt instances
#


include:
  - salt/master
  - salt/cloud
  - salt/syndic
  - services/sync



salt-masters:
  git.latest:
    - name: git@gitlab.crowdrise.com:devops/saltstack-pillar.git
    - target: /srv/salt/saltstack-filebase
    - identity: /srv/salt/.ssh/id_rsa
    - force: true
      - require:
        - pkg: git
        - user: salt
  pkg.installed:
    - names:
      - python-ws4py
      - python-cherrypy
