#
#   Min Base Configuration
#

base:
  {% set states = salt['cp.list_states'](env) %}

  {%-     if 'oscodename' in grains %}
  {%-       if ".".join(['os', grains['os'], grains['oscodename']]) in states %}
  oscodename:{{ grains['oscodename'] }}:
    - match: grain
    - os/{{ grains['os'] }}/{{ grains['oscodename'] }}
  {%-       endif %}
  {%-     endif %}
  {%-   endif %}
  {%-  endif %}
