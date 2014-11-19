#
#   base/min/autodns/init.sls
#   Configure auto dns for rackspace
#

https://github.com/linickx/rsdns.git:
  git.latest:
    - target: /usr/local/rsdns
