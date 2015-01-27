#
#   class/mon/init.sls
#   monitor class
#

include:
  - services/newrelic

{%  for lb in salt['grains.get']("loadbalancers", []) %}
{%    if lb.name and lb.id %}
/etc/rackspace-monitoring-agent.conf.d/loadbalancer-{{ lb.name }}.yaml:
  file.managed:
    - source: salt://class/mon/files/init.sls
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      target_name: {{ lb.name }}
      target_id: {{ lb.id }}
{%    endif %}
{%  endfor %}


