#
#   services/rackspace/init.sls
#   get a bunch of rackspace tools
#

rackspacebase:
  pkg.installed:
    - names:
      - python-dev
      - python-pip
      - build-essential

rackspace-tools:
  module.run:
    - name: pip.install
    - pkgs:
      - raxmon
      - python-clouddns
      - cloud_dns_cli
      - ptrcreate
      - python-cloudlb
      - python-cloudservers
      - pyrax
    - requires:
      - pkg: rackspacebase

cloudbackup-updater -v:
  cmd.run:
    - creates: /usr/local/bin/driveclient
    - requires:
      - pkg: cloudbackup-updater

/usr/local/bin/driveclient --configure --username {{ salt['pillar.get']('rackspace:username', 'user') }} --apikey {{ salt['pillar.get']('rackspace:apikey', 'api') }}:
  cmd.run:
    - creates: /etc/driveclient/bootstrap.json
    - requires:
      - pkg: cloudbackup-updater
      - file: /usr/local/bin/driveclient
      - cmd: cloudbackup-updater -v:

driveclient:
  pkg.installed:
    - sources:
      - cloudbackup-updater: http://agentrepo.drivesrvr.com/debian/cloudbackup-updater-latest.deb
  service.running:
    - requires:
      - cmd: cloudbackup-updater -v:
      - file: /etc/driveclient/bootstrap.json

include:
# - services/rackspace/autodns
  - services/rackspace/pyrax
  - services/rackspace/monitoring
