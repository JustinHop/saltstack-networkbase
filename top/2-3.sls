#
#   Min Base Configuration
#

base:
  {% set states = salt['cp.list_states'](env) %}

  {%  if 'business' in grains %}
  {%-   if grains['business'] in states %}
  business:{{ grains['business'] }}:
    - match: grain
    - {{ grains['business'] }}
  {%-   endif %}
  {%  endif %}
