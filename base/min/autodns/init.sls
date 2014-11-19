#
#   base/min/autodns/init.sls
#   Configure auto dns for rackspace
#

https://github.com/linickx/rsdns.git:
  git.latest:
    - target: /usr/local/rsdns
    - require:
      - pkg: git

update_rackspace:
  cmd.script:
    - source: salt://base/min/autodns/scripts/autodns.sh
    - cwd: /usr/local/rsdns
    - user: root
    - group: root
    - shell: /bin/bash
    - require: 
      - git: https://github.com/linickx/rsdns.git

