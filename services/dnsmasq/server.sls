# Include :download:`map file <map.jinja>` of OS-specific package names and
# file paths. Values can be overridden using Pillar.
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

{%- if salt['pillar.get']('dnsmasq:dnsmasq_conf') %}
dnsmasq_conf:
  file.managed:
    - name: {{ dnsmasq.dnsmasq_conf }}
    - source: {{ salt['pillar.get']('dnsmasq:dnsmasq_conf', 'salt://dnsmasq/files/dnsmasq.conf') }}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: dnsmasq

dnsmasq_conf_dir:
  file.recurse:
    - name: {{ dnsmasq.dnsmasq_conf_dir }}
    - source: {{ salt['pillar.get']('dnsmasq:dnsmasq_conf_dir', 'salt://dnsmasq/files/dnsmasq.d') }}
    - template: jinja
    - require:
      - pkg: dnsmasq
{%- endif %}

dnsmasq:
  pkg:
    - installed
  service:
    - running
    - name: {{ dnsmasq.service }}
    - enable: True
    - require:
      - pkg: dnsmasq
{%- if salt['pillar.get']('dnsmasq:dnsmasq_conf') %}
    - watch:
      - file: dnsmasq_conf
      - file: dnsmasq_conf_dir
{%- endif %}
