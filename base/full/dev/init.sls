
{% set states = salt['cp.list_states'](env) %}

{%  if ".".join(['base.full.dev.os', grains['os']]) in states %}
include:
  - base/full/dev/os/{{ grains['os'] }}
{%    if ".".join(['base.full.dev.os', grains['os'], grains['oscodename']]) in states %}
  - base/full/dev/os/{{ grains['os'] }}/{{ grains['oscodename'] }}
{%    endif %}
{%  endif %}

