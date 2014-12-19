#
#   services/percona/init.sls
#   stuff for percona XtraDB
#

percona-apt:
  pkgrepo.managed:
    - name: deb http://repo.percona.com/apt grains['oscodename'] }} main
    - keyid: 1C4CBDCDCD2EFD2A
    - require_in:
      - pkg: percona-xtradb-cluster-full-56
  pkg.latest:
    - pkgs: 
      - percona-xtradb-cluster-full-56
      - lvm2
      - automysqlbackup

