include:
  - base/min/ca
  - base/min/bin
  - base/min/hostsfile/hostname
  #- base/min/hostsfile/resolv
  #- base/min/pam


base-min-pkgs:
  pkg.installed:
    - names:
      - apt-file
      - bash-completion
      - bind9-host
      - bsdmainutils
      - chkrootkit
      - colortail
      - curl
      - debsums
      - dialog
      - git
      - iptables
      - multitail
      - ncurses-term
      - python-apt
      - rkhunter
      - swig
      - tmux
      - vim
      - zsh

