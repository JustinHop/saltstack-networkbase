#
#   reactor/states/git/stage-state.sls
#   do actual work for stage
#

#chown -R crowdrise:crowdrise /var/www/git:
#  cmd.run:
#    - user: root
#    - group: root
#    - order: 1
#
#git_stage_repo:
#  git.latest:
#    - name: git@gitlab.crowdrise.com:qa/qaloadtest.git
#    - target: /var/www/git/qaloadtest.git
#    - bare: true
#    - identity: /home/crowdrise/.ssh/id_dsa
#    - require:
#      - cmd: chown -R crowdrise:crowdrise /var/www/git
#    - order: 2
#
git archive --format=tar --remote=git@gitlab.crowdrise.com:qa/qaloadtest.git master | tar --totals -xvmpf - -C /var/www/vhosts/www.crowdrise.com/htdocs:
  cmd.run:
    - user: crowdrise
    - group: crowdrise
