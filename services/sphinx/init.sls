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

/etc/sphinxsearch/sphinx.conf:
  file.managed:
    - source: salt://services/sphinx/files/etc/sphinx-crowdrise.conf
    - user: root
    - group: root

/var/log/sphinxsearch:
  file.directory:
    - mode: 755
