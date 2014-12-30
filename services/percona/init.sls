#
#   services/percona/init.sls
#   stuff for percona XtraDB
#

include:
  - crowdrise/blockdev
  - services/newrelic/npi
  - services/mysql/newrelic

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
  pkg.installed:
    - names: 
      - percona-xtradb-cluster-client-5.6
      - percona-xtradb-cluster-server-5.6
      - percona-xtrabackup
      - percona-toolkit

/etc/mysql/my.cnf:
  file.managed:
    - source: salt://services/percona/files/{{ grains['mem_total'] }}/my.cnf
    - template: jinja
    - user: root
    - pass: root
    - makedirs: True

/usr/bin/mysql_install_db --user=mysql --explicit_defaults_for_timestamp=true:
  cmd.run:
    - user: root
    - group: root
    - creates:
      - /data1/mysqld/mysql/proc.MYD
    - requires:
      - file: /etc/mysql/my.cnf
      - pkg: percona-xtradb-cluster-server-5.6
