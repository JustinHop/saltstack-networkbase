#
#   class/back/init.sls
#   backup hosting systems
#

include:
  - crowdrise/blockdev


backuppackages:
  pkg.installed:
    - names:
      - automysqlbackup
      - lvm2
      - rsync
