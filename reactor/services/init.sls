{% set postdata = data.get('post', {}) %}

{% if postdata.secretkey == "hopWAShereANDthere" %}
service_init:
  cmd.service.{{ postdata.function }}:
    - tgt: '{{ postdata.tgt }}'
    {% if "matcher" in postdata %}
    - expr_form: {{ postdata.matcher }}
    {% endif %}
    - arg:
      - {{ postdata.args }}
{% endif %}
  
