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
    - name: /usr/bin/rackspace-monitoring-agent --setup --username {{ salt['pillar.get']('rackspace:username', 'justin.hoppensteadt') }} --apikey {{ salt['pillar.get']('rackspace:apikey', '993ee403ca934d5cbed5f79e4de5b8c6') }}
    - timeout: 15
    - creates: /etc/rackspace-monitoring-agent.cfg
    - require:
      - pkg: rackspace-monitoring-agent

rackspace-monitoring-agent:
  pkg.installed: []
  service.running:
    - name: rackspace-monitoring-agent
    - enable: true
    - restart: true
    - watch:
      - file: /etc/rackspace-monitoring-agent.conf.d
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
      target_disk: /dev/xvda1
      target_interface: lo
      target_proc: init
      target_proc_level: 'CRITICAL'

/usr/lib/rackspace-monitoring-agent/plugins:
  file.directory:
    - user: root
    - group: root
    - makedirs: true

https://github.com/racker/rackspace-monitoring-agent-plugins-contrib.git:
  git.latest:
    - target: /usr/lib/rackspace-monitoring-agent/plugins
    - require:
      - pkg: git

chmod +x /usr/lib/rackspace-monitoring-agent/plugins:
  cmd.run:
    - user: root
    - group: root
    - require:
      - git: https://github.com/racker/rackspace-monitoring-agent-plugins-contrib.git

/etc/rsyslog.d/rackspace-monitoring-daemon.conf:
  file.managed:
    - user: root
    - group: root
    - makedirs: True
    - source: salt://services/rackspace/files/rsyslog.conf

{% for interface in grains['ip_interfaces'] %}
{% if interface != 'lo' %}
/etc/rackspace-monitoring-agent.conf.d/network-{{ interface }}.yaml:
  file.managed:
    - source: salt://services/rackspace/files/monitoring/network.yaml
    - template: jinja
    - makedirs: true
    - user: root
    - group: root
    - defaults:
      target_interface: {{ interface }}

{%  endif %}
{% endfor %}

{% for proc in pillar['monitoring.proc'] %}
/etc/rackspace-monitoring-agent.conf.d/proc-{{ proc }}.yaml:
  file.managed:
    - source: salt://services/rackspace/files/monitoring/proc.yaml
    - template: jinja
    - makedirs: true
    - user: root
    - group: root
    - defaults:
      target_proc: {{ proc }}
      target_proc_level: 'CRITICAL'
{% endfor %}

