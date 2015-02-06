#
#   Min Base Configuration
#

base:
  {% set states = salt['cp.list_states'](env) %}

  {%- if 'os' in grains %}
  {%-   if ".".join(['os', grains['os']]) in states %}
  os:{{ grains['os'] }}:
    - match: grain
    - os/{{ grains['os'] }}

  {%-   endif %}
  {%- endif %}
