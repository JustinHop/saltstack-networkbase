#
#   reactor/states/git/salt.sls
#   update salt masters git repos
#

salt_update_stuffs:
  local.cmd.script:
    - tgt: 'G@product:salt'
    - expr_form: compound
    - arg:
      - salt://services/salt/scripts/update.sh
