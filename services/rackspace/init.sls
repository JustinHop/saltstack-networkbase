#
#   services/rackspace/init.sls
#   get a bunch of rackspace tools
#

rackspacebase:
  pkg.installed:
    - names:
      - python-dev
      - build-essential
      - nagios-plugins-contrib
      - nagios-plugins-extra
      - nagios-plugins-openstack

rackspace-tools:
  module.run:
    - name: pip.install
    - pkgs:
      - rackspace-monitoring
      - rackspace-monitoring-cli
      - python-clouddns
      - cloud_dns_cli
      - ptrcreate
      - python-cloudlb
      - python-cloudservers
      - pyrax
    - requires:
      - pkg: rackspacebase
      - pkg: python-dev

include:
  - services/rackspace/backup
  - services/rackspace/pyrax
  - services/rackspace/monitoring
  - services/rackspace/rackconnect

exclude:
  - sls: services/rackspace/autodns
