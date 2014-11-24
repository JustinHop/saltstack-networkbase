#
#   Profile init
#   base/min/profile/init.sls
#

https://github.com/JustinHop/Profile.git:
  git.latest:
    - target: /root/Profile

/etc/Profile:
  module.run:
    - name: git.submodule
    - cwd: /root/Profile

min-env:
  pkg.installed:
    - names:
      - zsh
      - tmux
      - vim-nox
      - wget
      - curl
      - bash-completion
      - fping
  cmd.script:
    - source: salt://base/min/profile/scripts/zshup.sh
    - user: root
    - group: root
    - shell: /bin/zsh

