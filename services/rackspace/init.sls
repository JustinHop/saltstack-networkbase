#
#   services/rackspace/init.sls
#   get a bunch of rackspace tools
#


python-dev:
  pkg:
    - installed

python-pip:
  pkg:
    - installed

rackspace-tools:
  module.run:
    - name: pip.install
    - pkgs:
      - rackspace-monitoring-cli
      - rackspace-monitoring
      - python-clouddns
      - cloud_dns_cli
      - agent.http
      - ptrcreate
      - rack
      - python-cloudlb
      - python-cloudservers
    - requires:
      - pkg: python-pip
      - pkg: python-dev
