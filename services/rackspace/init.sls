#
#   services/rackspace/init.sls
#   get a bunch of rackspace tools
#

rackspace-monitoring-repo:
  pkgrepo.managed:
    - name: deb http://stable.packages.cloudmonitoring.rackspace.com/ubuntu-{{ grains['lsb_distrib_release'] }}-x86_64 cloudmonitoring main
    - key_url: https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc
    - require_in:
      - pkg: rackspace-monitoring-agent
  pkg.installed:
    - name: rackspace-monitoring-agent
  cmd.run:
    - name: /usr/bin/rackspace-monitoring-agent --setup --username {{ salt['pillar.get']('rackspace:user', 'user') }} --apikey {{ salt['pillar.get']('rackspace:api', 'api') }}
    - timeout: 15
    - creates:
      - /etc/rackspace-monitoring-agent.cfg
  service.running:
    - name: rackspace-monitoring-agent
    - require:
      - pkg: rackspace-monitoring-agent

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

cloudbackup-updater -v:
  cmd.run:
    - creates: /usr/local/bin/driveclient

/usr/local/bin/driveclient --configure --username {{ salt['pillar.get']('rackspace:user', 'user') }} --apikey {{ salt['pillar.get']('rackspace:api', 'api') }}:
  cmd.run:
    - creates: /etc/driveclient/bootstrap.json
    - requires:
      - pkg: cloudbackup-updater
      - file: /usr/local/bin/driveclient

driveclient:
  pkg.installed:
    - sources:
      - cloudbackup-updater: http://agentrepo.drivesrvr.com/debian/cloudbackup-updater-latest.deb
  service.running:
    - requires:
      - file: /etc/driveclient/bootstrap.json
