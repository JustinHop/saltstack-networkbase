#
#   Profile init
#   base/min/profile/init.sls
#

https://github.com/JustinHop/Profile.git:
  git.latest:
    - target: /etc/Profile

/etc/Profile:
  module.run:
    - name: git.submodule
    - cwd: /etc/Profile

/etc/bash.bashrc:
  file.managed:
    - source: salt://base/min/profile/files/bash.bashrc

/etc/vim/vimrc:
  file.managed:
    - source: salt://base/min/profile/files/vimrc

/etc/zsh:
  file.recurse:
    - source: salt://base/min/profile/files/zsh

/etc/tmux.conf:
  file.symlink:
    - target: /etc/Profile/tmux.conf

/etc/inputrc:
  file.append:
    - text:
      - "$include /etc/Profile/inputrc"


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
    - source: salt://base/min/profile/scripts/linkbin.sh
    - user: root
    - group: root
    - shell: /bin/bash

