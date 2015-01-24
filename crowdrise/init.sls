#
#   crowdrise/init.sls
#   base for crowdrise systems
#

include:
  - crowdrise/bin
  - crowdrise/selfcert
  - crowdrise/hostsfile
  - crowdrise/profile
  - crowdrise/rackconnect
  - crowdrise/rclocal
  - services/chkrootkit

python-pip:
  pkg.removed:
    - order:
      - 1

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
      - haveged
      - htop
      - iotop
      - iptables
      - lockfile-progs
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
      - update-notifier-common
      - zsh
    - order:
      - 2

six:
  pip.installed:
    - reload_modules: True
    - require:
      - pkg: git
      - cmd: get-pip-latest

get-pip-latest:
  cmd.run:
    - name: curl -L https://bootstrap.pypa.io/get-pip.py | python
    - user: root
    - group: root
    - creates: /usr/local/bin/pip
    - order: 2
    - require:
      - pkg: python-dev
      - pkg: build-essential
      - pkg: git

userdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root
    - order:
      - 1

groupdel ubuntu || echo hello:
  cmd.run:
    - user: root
    - group: root
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

{% grains.setval("monitoring.proc", ["salt-minion", "sshguard", "rackspace-monitoring-agent", "cron", "rsyslogd", "sshd" ]) %}
