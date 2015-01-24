#
#   class/back/init.sls
#   backup hosting systems
#

include:
  #- crowdrise/blockdev
  - crowdrise/lvm
  - services/percona


backuppackages:
  pkg.installed:
    - names:
      - automysqlbackup
      - lvm2
      - rsync
