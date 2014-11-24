#
#   services/rackspace/init.sls
#   get a bunch of rackspace tools
#


rackspace-tools:
  module.run:
    - name: pip.install
    - pkgs:
      - python-clouddns
      - ptrcreate
      - rack
      - python-cloudlb
      - python-cloudservers
    - requires:
      - pkg: python-pip
