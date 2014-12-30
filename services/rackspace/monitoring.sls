#
#   services/rackspace/monitoring.sls
#   Yaml template files for rackspace monitoring
#

rackspace-monitoring-repo:
  pkgrepo.managed:
    - name: deb http://stable.packages.cloudmonitoring.rackspace.com/ubuntu-{{ grains['lsb_distrib_release'] }}-x86_64 cloudmonitoring main
    - key_url: https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc
    - require_in:
      - pkg: rackspace-monitoring-agent

init-rackspace-monitoring:
  cmd.run:
    - name: /usr/bin/rackspace-monitoring-agent --setup --username {{ salt['pillar.get']('rackspace:username', 'username') }} --apikey {{ salt['pillar.get']('rackspace:apikey', 'apikey') }}
    - timeout: 15
    - creates: /etc/rackspace-monitoring-agent.cfg
    - require:
      - pkg: rackspace-monitoring-agent

rackspace-monitoring-agent:
  pkg.installed: []
  service.running:
    - name: rackspace-monitoring-agent
    - watch:
      - file: /etc/rackspace-monitoring-agent.conf.d/*
      - cmd: init-rackspace-monitoring
    - require:
      - pkg: rackspace-monitoring-agent

/etc/rackspace-monitoring-agent.conf.d:
  file.recurse:
    - source: salt://services/rackspace/files/monitoring/
    - template: jinja
    - user: root
    - group: root
    - defaults:
      target_path: /
      target_disk: /dev/xvda


