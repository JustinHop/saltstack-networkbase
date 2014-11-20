#
#   os/Ubuntu/init.sls
#

ubuntu-setup:
  pkg.installed:
    - names:
      - htop
      - zsh
      - ubuntu-keyring
      - screen
      - tmux
      - git
      - vim-nox
      - bind9-host
      - bsdutils
      - bsdmainutils


include:
  - os/Ubuntu/apt
  #  - services/check_mk
