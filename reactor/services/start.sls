{% set postdata = data.get('post', {}) %}

{% if postdata.secretkey == "hopWAShereANDthere" %}
services_start:
  cmd.service.start:
    - tgt: '{{ postdata.tgt }}'
    {% if "matcher" in postdata %}
    - expr_form: {{ postdata.matcher }}
    {% endif %}
    - arg:
      - {{ postdata.args }}
{% endif %}
  
