#
#   class/mon/init.sls
#   monitor class
#

include:
  - services/newrelic

{%  for lb in salt['pillar.get']('lb', {}) %}

echo {{ lb.name|e }}:
  cmd.run

{%    if lb.name is defined and lb.id is defined %}
/etc/rackspace-monitoring-agent.conf.d/loadbalancer-{{ lb.name }}.yaml:
  file.managed:
    - source: salt://class/mon/files/init.sls
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      target_name: {{ lb.name|e }}
      target_id: {{ lb|e }}
{%    endif %}
{%  endfor %}


