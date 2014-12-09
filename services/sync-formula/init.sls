{%- from 'sync/settings.jinja' import sync with context %}

# Add entries to hostsfile. csync2 likes to use hosts
{%- for host, ips in sync.hosts.iteritems() %}
host-{{ host }}:
  host.present:
    - ip: {{ ips[0] }}
    - names:
      - {{ sync.hostnames[host] }}
{%- endfor %}

# Required software
sync-software:
  pkg.installed:
    - pkgs:
      - xinetd
      - csync2
      - lsyncd

# csync2 configuration for xinetd
{{ sync.xinetd_path }}/csync2:
  file.managed:
    - source: salt://sync/files/xinetd.d/csync2
    - template: jinja
    - mode: 644
    - user: root
    - group: root

# csync2 directory
{{ sync.csync2_path }}:
  file.directory:
    - user: root
    - group: root
    - mode: 660
    - makkedirs: True

# Preshared csync2 key
{{ sync.csync2_path }}/csync2.key:
  file.managed:
    - source: salt://sync/files/csync2/csync2.key
    - mode: 600
    - requires:
      - file: {{ sync.csync2_path }}

# Bidirectional csync2 config
{{ sync.csync2_path }}/csync2.cfg:
  file.managed:
    - source: salt://sync/files/csync2/csync2.cfg
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - requires:
      - file: {{ sync.csync2_path }}

# Symlink for the above configuration
/etc/csync2.cfg:
  file.symlink:
    - target: {{ sync.csync2_path }}/csync2.cfg
    - force: True
    - requires:
      - file: {{ sync.csync2_path }}/csync2.cfg

# Create a directional config for every host on every host.
# May not be necessary but assuming for now it is at least useful.
{% for host in sync.hosts.keys() %}
{% set hostname = sync.hostnames[host] %}
{% set clean_hostname = hostname.translate(None, '_-.') %}
{{ sync.csync2_path }}/csync2_{{ clean_hostname }}.cfg:
  file.managed:
    - source: salt://sync/files/csync2/directional.cfg
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        current_hostname: "{{ hostname }}"
    - requires:
      - file: {{ sync.csync2_path }}

/etc/csync2_{{ clean_hostname }}.cfg:
  file.symlink:
    - target: {{ sync.csync2_path }}/csync2_{{ clean_hostname }}.cfg
    - requires:
      - file: {{ sync.csync2_path }}/csync2_{{ clean_hostname }}.cfg
{% endfor %}

xinetd:
  service:
    - running
    - enable: True
    - watch:
      - file: {{ sync.xinetd_path }}/csync2

/etc/lsyncd/lsyncd.conf.lua:
  file.managed:
    - source: salt://sync/files/lsyncd/lsyncd.conf.lua
    - makedirs: True
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/var/log/lsyncd:
  file.directory:
    - makdirs: True
    - mode: 644

lsyncd:
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/lsyncd/lsyncd.conf.lua
      - file: /var/log/lsyncd
