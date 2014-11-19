#
#   base/min/autodns/init.sls
#   Configure auto dns for rackspace
#

https://github.com/linickx/rsdns.git:
  git.latest:
    - target: /usr/local/rsdns
  cmd.script:
    - source: salt://base/min/autodns/scripts/autodns.sh
    - user: root
    - group: root
    - shell: /bin/bash
