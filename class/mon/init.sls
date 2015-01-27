#
#   class/mon/init.sls
#   monitor class
#

include:
  - services/newrelic

{%  for lb, attr in salt['grains.item']('loadbalancers', {})|dictsort() %}

echo {{ lb|e }}:
  cmd.run

{%    if attr.name is defined and attr.id is defined %}
/etc/rackspace-monitoring-agent.conf.d/loadbalancer-{{ attr.name }}.yaml:
  file.managed:
    - source: salt://class/mon/files/init.sls
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      target_name: {{ attr.name|e }}
      target_id: {{ attr.id|e }}
{%    endif %}
{%  endfor %}


