#
#   services/percona/init.sls
#   stuff for percona XtraDB
#

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
      - pkg: percona-xtradb-cluster-full-56
  pkg.latest:
    - names: 
      - percona-xtradb-cluster-server-5.6
      - percona-xtradb-cluster-full-56
      - percona-xtrabackup
      - percona-toolkit

