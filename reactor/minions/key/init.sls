{% set postdata = data.get('post', {}) %}

{% if postdata.secretkey == "b164b4a2-e763-4c65-a799-59e9280262ab" %}
minion_key_{{ postdata.function }}:
  wheel.key.{{ postdata.function }}:
    - match: '{{ postdata.minion }}'
{% endif %}
  
