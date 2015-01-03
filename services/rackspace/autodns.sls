#
#   base/autodns/init.sls
#   Configure auto dns for rackspace
#

git:
  pkg:
    - installed

https://github.com/linickx/rsdns.git:
  git.latest:
    - target: /usr/local/rsdns
    - require:
      - pkg: git

update_rackspace:
  cmd.script:
    - source: salt://services/rackspace/scripts/autodns.sh
    - cwd: /usr/local/rsdns
    - user: root
    - group: root
    - shell: /bin/bash
    - template: jinja
    - require: 
      - git: https://github.com/linickx/rsdns.git
    - onfail:
      - rackspace: setup_domain

