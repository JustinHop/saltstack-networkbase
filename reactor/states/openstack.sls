{% set postdata = data.get('post', {}) %}
{% set tops = ['nova', 'lb', 'domain'] %}
{% set acts = ['added', 'changed', 'removed'] %}

logthis-openstack-reactor:
  runner.pillar.items:
    - ret: syslog_return
    - kwarg:
      pillar:
        post: {{ postdata }}

{%  if postdata.secretkey == "1f938f7c-2744-4dd3-ae66-b26e295baac0" %}
{%    for top in tops %}
highhosts-{{ top }}:
  local.state.top:
    - tgt: 'master*.salt.*'
    - arg:
      'top/openstack-{{ top }}.sls'
    - kwarg:
      pillar:
        openstack: {{ postdata[top] }}
{%    endfor %}
{%  endif %}
