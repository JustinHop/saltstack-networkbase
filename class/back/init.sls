#
#   class/back/init.sls
#   backup hosting systems
#

include:
  #- base/blockdev
  - base/lvm
  - services/percona


backuppackages:
  pkg.installed:
    - names:
      - automysqlbackup
      - lvm2
      - rsync
