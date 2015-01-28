#
#   class/mon/init.sls
#   monitor class
#

include:
  - services/newrelic
  - services/nginx

{%  for id, lb in salt['pillar.get']('lb', {}).items() %}

echo {{ id }}:
  cmd.run

{%    if lb.name is defined and id is defined %}
/etc/rackspace-monitoring-agent.conf.d/loadbalancer-{{ lb.name }}.yaml:
  file.managed:
    - source: salt://class/mon/files/loadbalancer.yaml
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      target_name: {{ lb.name }}
      target_id: {{ id }}
{%    endif %}
{%  endfor %}


npm:
  pkg.installed

sitespeed.io:
  npm.install:
    - require:
      - pkg: npm

