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

cloudbackup-updater -v:
  cmd.run:
    - creates: /usr/local/bin/driveclient
    - requires:
      - pkg: cloudbackup-updater

/usr/local/bin/driveclient:
  cmd.run:
    - name: rm /etc/driveclient/bootstrap.json; /usr/local/bin/driveclient --configure --username {{ salt['pillar.get']('rackspace:username', 'user') }} --apikey {{ salt['pillar.get']('rackspace:apikey', 'api') }}
    - requires:
      - pkg: cloudbackup-updater
      - file: /usr/local/bin/driveclient
      - cmd: cloudbackup-updater -v
      - pkg: driveclient

driveclient:
  pkg.installed:
    - sources:
      - cloudbackup-updater: http://agentrepo.drivesrvr.com/debian/cloudbackup-updater-latest.deb
  service.running:
    - requires:
      - cmd: cloudbackup-updater -v
      - onfail:
        - cmd: /usr/local/bin/driveclient


include:
  - services/rackspace/autodns
  - services/rackspace/pyrax
  - services/rackspace/monitoring
