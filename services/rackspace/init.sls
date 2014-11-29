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
      - python-clouddns
      - cloud_dns_cli
      - ptrcreate
      - python-cloudlb
      - python-cloudservers
    - requires:
      - pkg: python-pip
      - pkg: python-dev

six:
  module.run:
    - name: pip.install
    - upgrade: True
    - pkgs:
      - six
