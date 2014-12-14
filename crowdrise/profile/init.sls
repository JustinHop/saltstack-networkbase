#
#   Profile init
#   crowdrise/profile/init.sls
#

min-env:
  pkg.installed:
    - names:
      - zsh
      - git
      - tmux
      - vim-nox
      - wget
      - curl
      - bash-completion
      - fping

https://github.com/JustinHop/Profile.git:
  git.latest:
    - target: /root/Profile
    - require:
      - pkg: git

/etc/Profile:
  module.run:
    - name: git.submodule
    - cwd: /root/Profile
    - require:
      - pkg: git

link-profile:
  cmd.script:
    - source: salt://crowdrise/profile/scripts/zshup.sh
    - user: root
    - group: root
    - shell: /bin/zsh
    - require:
      - pkg: zsh
      - pkg: git

