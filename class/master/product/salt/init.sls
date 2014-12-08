#
# class/master/product/salt/init.sls
# master.salt instances
#

include:
  - salt/master

salt '*' test.ping:
  cron.present:
    - identifier: SaltConnect
    - user: root
    - minute: '*/10'

git@gitlab.crowdrise.io/devops/saltstack-filebase.git:
  git.latest:
    - target: /srv/salt/saltstack-filebase
    - force: true
    - identity: /srv/salt/id_rsa

git@gitlab.crowdrise.io/devops/saltstack-pillar.git:
  git.latest:
    - target: /srv/salt/saltstack-pillar
    - force: true
    - identity: /srv/salt/id_rsa

git@gitlab.crowdrise.io/devops/sphinx.git:
  git.latest:
    - target: /srv/salt/formulas/sphinx
    - force: true
    - identity: /srv/salt/id_rsa
