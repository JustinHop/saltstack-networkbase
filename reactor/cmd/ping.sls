#
#   reactor/cmd/ping.sls
#   poc for ping
{% set postdata = data.get('post', {}) %}

command_run:
  local.cmd.run:
    - tgt: '*stage*'
    - args:
      - ["echo", '{{  postdata }}']
