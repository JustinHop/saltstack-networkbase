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
    - watch:
      - file: /etc/sphinxsearch/sphinx.conf
      - pkg: sphinxsearch

/etc/sphinxsearch:
  file.directory:
    - user: root
    - group: root


sphinxsearch-git:
  git.latest:
    - name: git@crowdrise.git.beanstalkapp.com:/crowdrise/sphinx.git
    - rev: master
    - target: /etc/sphinxsearch
    - identity: /home/beanstalk/.ssh/id_rsa
    - force: true
    - require:
      - pkg: git
      - user: beanstalk
      - file: /etc/sphinxsearch

/var/log/sphinxsearch:
  file.directory:
    - mode: 755

/usr/bin/indexer --all --rotate:
  cron.present:
    - identifier: sphinxupdate
    - user: root
    - minute: '*/10'
