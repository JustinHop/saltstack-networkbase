{% set postdata = data.get('post', {}) %}

{% if postdata.secretkey == "hopWAShereANDthere" %}
services_reload:
  cmd.service.reload:
    - tgt: '{{ postdata.tgt }}'
    {% if "matcher" in postdata %}
    - expr_form: {{ postdata.matcher }}
    {% endif %}
    - arg:
      - {{ postdata.args }}
{% endif %}
  
