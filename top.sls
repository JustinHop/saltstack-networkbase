#
#   Base Configuration
#

base:
  {% set states = salt['cp.list_states'](env) %}

  '*':
    - users
    - base/min
    - services/openssh
    - services/openssh/server
    - excludes
    #
    # These are github hosted formulas
    #
    - sysstat
    #
    # End Gitlab
    #
    {%-  if 'roles' in grains %}
    {%-    for role in grains['roles'] %}
    {%-      if role in states %}
    - {{ role }}
    {%-      endif %}
    {%-    endfor %}
    {%-  endif %}
    {%-  if 'virtual_subtype' in grains %}
    {%-    for virtual_subtype in grains['virtual_subtype'] %}
    {%-      if ".".join(['sys.virtual', grains['virtual_subtype']|replace(" ", "_")]) in states %}
    - sys/virtual/{{ grains['virtual_subtype']|replace(" ", "_") }}
    {%-      endif %}
    {%-    endfor %}
    {%-  elif 'virtual' in grains %}
    {%-    for virtual in grains['virtual'] %}
    {%-      if ".".join(['sys.virtual', grains['virtual']|replace(" ", "_")]) in states %}
    - sys/virtual/{{ grains['virtual']|replace(" ", "_") }}
    {%-      endif %}
    {%-    endfor %}
    {%-  else %}
    - sys/physical
    {%    if 'productname' in grains %}
    {%      if ".".join(['sys.physical', grains['productname']|replace(" ", "_")]) in states %}
  productname:{{ grains['productname'] }}:
    - match: grain
    - sys/physical/{{ grains['productname']|replace(" ", "_") }}
    {%      endif %}
    {%    endif %}
    {%  endif %}

  {%  if 'os' in grains %}
  {%    if ".".join(['os', grains['os']]) in states %}
  os:{{ grains['os'] }}:
    - match: grain
    - os/{{ grains['os'] }}

  {%      if 'oscodename' in grains %}
  {%        if ".".join(['os', grains['os'], grains['oscodename']]) in states %}
  oscodename:{{ grains['oscodename'] }}:
    - match: grain
    - os/{{ grains['os'] }}/{{ grains['oscodename'] }}
  {%        endif %}
  {%      endif %}
  {%    endif %}
  {%  endif %}

  {%  if 'business' in grains %}
  {%    if grains['business'] in states %}
  business:{{ grains['business'] }}:
    - match: grain
    - {{ grains['business'] }}
  {%    endif %}
  {%  endif %}

  {%  if 'cluster' in grains %}
  {%    if ".".join(['cluster', grains['cluster']]) in states %}
  cluster:{{ grains['cluster'] }}:
    - match: grain
    - cluster/{{ grains['cluster'] }}
  {%    endif %}
  {%  endif %}

  {%  if 'product' in grains %}
  {%    if ".".join(['product', grains['product']]) in states %}
  product:{{ grains['product'] }}:
    - match: grain
    - product/{{ grains['product'] }}
  {%      if 'class' in grains %}
  {%        if ".".join(['product', grains['product'], 'class', grains['class']]) in states %}
    - product/{{ grains['product'] }}/class/{{ grains['class'] }}
  {%        endif %}
  {%      endif %}
  {%    endif %}
  {%  endif %}

  {%  if 'class' in grains %}
  {%    if ".".join(['class', grains['class']]) in states %}
  class:{{ grains['class'] }}:
    - match: grain
    - class/{{ grains['class'] }}
  {%      if 'class_instance' in grains %}
  {%        if ".".join(['class', grains['class'], grains['class_instance']]) in states %}
    - class/{{ grains['class'] }}/{{ grains['class_instance'] }}
  {%        endif %}
  {%      endif %}
  {%      if 'product' in grains %}
  {%        if ".".join(['class', grains['class'], 'product', grains['product']]) in states %}
    - class/{{ grains['class'] }}/product/{{ grains['product'] }}
  {%        endif -%}
  {%      endif -%}
  {%    endif -%}
  {%  endif -%}

  {%-  if ".".join(['host', grains['host']]) in states %}
  host:{{ grains['host'] }}:
    - match: grain
    - host/{{ grains['host'] }}
  {%  endif %}



  '*.*':
    - services/rackspace
    - services/salt/minion
    - last

