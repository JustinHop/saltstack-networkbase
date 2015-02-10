{% set postdata = data.get('post', {}) %}

{% if postdata.secretkey == "1f938f7c-2744-4dd3-ae66-b26e295baac0" %}
highhosts:
  local.state.top:
    - tgt: '*'
    - arg:
      'top/hostsfile.sls'

{% endif %}

#state_state:
#  local.state.sls:
#    - tgt: 'master1.salt.prod1.crowdrise.io'
#    {% if "matcher" in postdata %}
#    - expr_form: {{ postdata.matcher }}
#    {% endif %}
#    - arg:
#      - {{ postdata.args }}
