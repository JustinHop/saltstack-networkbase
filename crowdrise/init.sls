include:
  - crowdrise/rackconnect
  - crowdrise/rclocal
  - crowdrise/hostsfile
  - crowdrise/bin
  - crowdrise/profile
  - services/chkrootkit
  #- crowdrise/hostsfile/resolv
  #- crowdrise/pam

base-min-nopkg:
  pkg.removed:
    - name: python-pip

base-min-pkgs:
  pkg.installed:
    - names:
      - apt-file
      - bash-completion
      - bind9-host
      - bsdmainutils
      - btrfs-tools
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
      - unattended-upgrades
      - zsh

/etc/apt/apt.conf.d/10periodic:
  file.managed:
    - source: salt://crowdrise/files/10periodic
    - user: root
    - group: root

/etc/apt/apt.conf.d/50unattended-upgrades:
  file.managed:
    - source: salt://crowdrise/files/50unattended-upgrades
    - user: root
    - group: root

six:
  module.run:
    - name: pip.install
    - upgrade: True
    - pkgs:
      - six
      - pyrax
    - require:
      - pkg: bash-min-pkgs
    - reload_modules: True


curl -L https://bootstrap.pypa.io/get-pip.py | python:
  cmd.run:
    - user: root
    - group: root
    - onfail: six

userdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root


groupdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root
