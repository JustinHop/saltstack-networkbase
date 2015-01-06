include:
  - crowdrise/rackconnect
  - crowdrise/rclocal
  - crowdrise/hostsfile
  - crowdrise/bin
  - crowdrise/profile
  - services/chkrootkit
  #- crowdrise/hostsfile/resolv
  #- crowdrise/pam

git:
  pkg.installed:
    - order:
      - 1

build-essential:
  pkg.installed:
    - order:
      - 1

base-min-pkgs:
  pkg.installed:
    - names:
      - apt-file
      - bash-completion
      - bind9-host
      - bsdmainutils
      - btrfs-tools
      - ca-certificates
      - chkrootkit
      - colortail
      - curl
      - debsums
      - etckeeper
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
    - order:
      - 1

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
  pip.install:
    - upgrade: True
    - reload_modules: True
    - pkgs:
      - six
      - pyrax
    - order:
      - 3
    - require:
      - pkg: git

curl -L https://bootstrap.pypa.io/get-pip.py | python:
  cmd.run:
    - user: root
    - group: root
    - onfail:
      - six

userdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root
    - order:
      - 2


groupdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root
    - order:
      - 2
