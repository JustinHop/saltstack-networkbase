#
#   Min Base Configuration
#

base:
  {% set states = salt['cp.list_states'](env) %}

  '*':
    - users
    - services/openssh
    - services/openssh/server
    - services/rsyslog
    - excludes

  {%- if 'os' in grains %}
  {%-   if ".".join(['os', grains['os']]) in states %}
  os:{{ grains['os'] }}:
    - match: grain
    - os/{{ grains['os'] }}

  {%-     if 'oscodename' in grains %}
  {%-       if ".".join(['os', grains['os'], grains['oscodename']]) in states %}
  oscodename:{{ grains['oscodename'] }}:
    - match: grain
    - os/{{ grains['os'] }}/{{ grains['oscodename'] }}
  {%-       endif %}
  {%-     endif %}
  {%-   endif %}
  {%-  endif %}

  {%  if 'business' in grains %}
  {%-   if grains['business'] in states %}
  business:{{ grains['business'] }}:
    - match: grain
    - {{ grains['business'] }}
  {%-   endif %}
  {%  endif %}


  '*.*':
    - services/rackspace
    - salt/minion
    - last
