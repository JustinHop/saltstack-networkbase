{% set postdata = data.get('post', {}) %}

{% if postdata.secretkey == "1f938f7c-2744-4dd3-ae66-b26e295baac0" %}
highhosts:
  local.state.top:
    - tgt: '*'
    - arg:
      'top/hostsfile.sls'

{% endif %}
