#
#   top/openstack-nova.sls
#   Finally get to do work on openstack data
#

/var/log/salt/pillar.log:
  file.managed:
    - user: syslog
    - group: syslog
    - contents: |
      {{ salt['pillar.get']('openstack')|indent(8) }}
