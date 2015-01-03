include:
  - crowdrise/rackconnect
  - crowdrise/rclocal
  - crowdrise/hostsfile
  - crowdrise/bin
  - crowdrise/profile
  - services/chkrootkit
  #- crowdrise/hostsfile/resolv
  #- crowdrise/pam

base-min-pkgs:
  pkg.installed:
    - names:
      - apt-file
      - bash-completion
      - bind9-host
      - bsdmainutils
      - build-essential
      - ca-certificates
      - chkrootkit
      - colortail
      - curl
      - debsums
      - etckeeper
      - git
      - htop
      - iotop
      - iptables
      - moreutils
      - mosh
      - multitail
      - ncurses-term
      - pv
      - python-apt
      - python-pip
      - python-dev
      - rkhunter
      - rlwrap
      - screen
      - socat
      - stow
      - strace
      - swig
      - tmux
      - vim
      - zsh

six:
  module.run:
    - name: pip.install
    - upgrade: True
    - pkgs:
      - six
      - pyrax
    - require:
      - pkg: python-pip
      - pkg: git
    - reload_modules: True

userdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root


groupdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root
