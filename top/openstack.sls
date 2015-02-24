#
#   top/openstack-domain.sls
#   Finally get to do work on openstack data
#

/var/log/salt/pillar.log-domain:
  file.managed:
    - name: /var/log/salt/pillar.log
    - user: syslog
    - group: syslog
    - contents: |
      {{ salt['pillar.get']('openstack')|indent(8) }}
