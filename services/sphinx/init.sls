#
#   services/sphinx/init.sls
#   sphinx config
#

sphinxsearch:
  pkg.installed:
    - sources:
      - sphinxsearch: salt://repo/sphinxsearch_2.2.5-release-0ubuntu12~trusty_amd64.deb
  service:
    - running
    - enable: True
    - requires:
      #- git: sphinxsearch-git
      - pkg: sphinxsearch
      - file: /etc/sphinxsearch/sphinx.conf
    - watch:
      #- git: sphinxsearch-git
      - pkg: sphinxsearch
      - file: /etc/sphinxsearch/sphinx.conf

/etc/sphinxsearch:
  file.directory:
    - user: root
    - group: root

/etc/sphinxsearch/sphinx.conf:
  file.managed:
    - source: salt://services/sphinx/gitlab/sphinx.conf
    - user: root
    - group: root
    - mode: 755
    - template: jinja

#sphinxsearch-git:
#  git.latest:
#    - name: git@crowdrise.git.beanstalkapp.com:/crowdrise/sphinx.git
#    - rev: master
#    - target: /etc/sphinxsearch.git
#    - identity: /home/beanstalk-pull/.ssh/id_rsa
#    - makedirs: true
#    - force: true
#    - require:
#      - pkg: git
#      - user: beanstalk
#      - file: /etc/sphinxsearch

/var/log/sphinxsearch:
  file.directory:
    - mode: 755

/usr/bin/indexer --all --rotate:
  cron.present:
    - identifier: sphinxupdate
    - user: root
    - minute: '*/10'
