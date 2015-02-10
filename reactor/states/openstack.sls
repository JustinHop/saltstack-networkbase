{% set postdata = data.get('post', {}) %}

{%  if postdata.secretkey == "1f938f7c-2744-4dd3-ae66-b26e295baac0" %}
{%    if postdata.nova.added or postdata.nova.changed or postdata.nova.changed %}
highhosts:
  local.state.top:
    - tgt: '*'
    - arg:
      'top/hostsfile.sls'

{%    endif %}
{%  endif %}
