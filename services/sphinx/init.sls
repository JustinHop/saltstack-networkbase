#
#   services/sphinx/init.sls
#   sphinx config
#

sphinx:
  pkg.installed:
    - sources:
      - sphinxsearch: salt://repo/sphinxsearch_2.2.5-release-0ubuntu12~trusty_amd64.deb
