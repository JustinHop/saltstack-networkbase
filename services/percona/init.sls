#
#   services/percona/init.sls
#   stuff for percona XtraDB
#

include:
  - crowdrise/blockdev

percona-needed:
  pkg.installed:
    - names:
      - lvm2
      - automysqlbackup

percona-apt:
  pkgrepo.managed:
    - name: deb http://repo.percona.com/apt {{ grains['oscodename'] }} main
    - keyid: 1C4CBDCDCD2EFD2A
    - keyserver: keys.gnupg.net
    - require_in:
      - pkg: percona-apt
  pkg.latest:
    - names: 
      - percona-xtradb-cluster-client-5.6
      - percona-xtradb-cluster-server-5.6
      - percona-xtrabackup
      - percona-toolkit



