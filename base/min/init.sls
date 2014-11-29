include:
  - base/min/rackconnect
  - base/min/hostsfile
  - base/min/bin
  - base/min/profile
  - base/min/autodns
  #- base/min/hostsfile/resolv
  #- base/min/pam


base-min-pkgs:
  pkg.installed:
    - names:
      - apt-file
      - bash-completion
      - bind9-host
      - bsdmainutils
      - ca-certificates
      - chkrootkit
      - colortail
      - curl
      - debsums
      - dialog
      - etckeeper
      - git
      - htop
      - iotop
      - iptables
      - multitail
      - mosh
      - ncurses-term
      - python-apt
      - rkhunter
      - swig
      - tmux
      - vim
      - zsh



userdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root


groupdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root
