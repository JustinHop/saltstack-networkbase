#
#   class/master/product/salt/cluster/prod/init.sls
#   prod salt master
#

salt '*' test.ping:
  cron.present:
    - identifier: SaltConnect
    - user: root
    - minute: '*/10'


salt-call state.sls class.master.product.salt:
  cron.present:
    - identifier: SaltPull
    - user: root
    - minute: '*'


git@gitlab.crowdrise.io:devops/saltstack-filebase.git:
  git.latest:
    - target: /srv/salt/saltstack-filebase
    - force: true
    - force_checkout: true
    - identity: /srv/salt/.ssh/id_rsa

git@gitlab.crowdrise.io:devops/saltstack-pillar.git:
  git.latest:
    - target: /srv/salt/saltstack-pillar
    - force: true
    - force_checkout: true
    - identity: /srv/salt/.ssh/id_rsa

git@gitlab.crowdrise.io:devops/sphinx.git:
  git.latest:
    - target: /srv/salt/formulas/sphinx
    - force: true
    - force_checkout: true
    - identity: /srv/salt/.ssh/id_rsa
