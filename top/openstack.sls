#
#   top/openstack-domain.sls
#   Finally get to do work on openstack data
#

date >> /var/log/salt/test.log:
  cmd.run:
    - user: syslog
    - group: syslog
