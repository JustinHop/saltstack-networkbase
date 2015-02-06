{% set postdata = data.get('post', {}) %}

{% if postdata.secretkey == "hopWAShereANDthere" %}
command_run:
  cmd.cmd.run:
    - tgt: '{{ postdata.tgt }}'
    {% if "matcher" in postdata %}
    - expr_form: {{ postdata.matcher }}
    {% endif %}
    - arg:
      - {{ postdata.args }}
{% endif %}
  
