#
#   services/percona/init.sls
#   stuff for percona XtraDB
#


percona-apt:
  pkgrepo.managed:
    - name: deb http://repo.percona.com/apt grains['oscodename'] }} main
    - keyid: 1C4CBDCDCD2EFD2A
