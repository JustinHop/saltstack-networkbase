#
# class/master/product/salt/init.sls
# master.salt instances
#


include:
  - salt/master
  - salt/cloud
  - salt/syndic
  - services/sync

/srv/salt/saltstack-filebase:
  git.latest:
    - name: git@gitlab.crowdrise.com:devops/saltstack-pillar.git
    - target: /srv/salt/saltstack-filebase
    - identity: /srv/salt/.ssh/id_rsa
    - force: true
      - require:
        - pkg: git
        - user: salt
