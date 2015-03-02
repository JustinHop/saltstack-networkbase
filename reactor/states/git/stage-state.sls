#
#   reactor/states/git/stage-state.sls
#   do actual work for stage
#

#chown -R base:base /var/www/git:
#  cmd.run:
#    - user: root
#    - group: root
#    - order: 1
#
#git_stage_repo:
#  git.latest:
#    - name: git@gitlab.base.com:qa/qaloadtest.git
#    - target: /var/www/git/qaloadtest.git
#    - bare: true
#    - identity: /home/base/.ssh/id_dsa
#    - require:
#      - cmd: chown -R base:base /var/www/git
#    - order: 2
#
git archive --format=tar --remote=git@gitlab.base.com:qa/qaloadtest.git master | tar --totals -xvmpf - -C /var/www/vhosts/www.base.com/htdocs:
  cmd.run:
    - user: base
    - group: base
