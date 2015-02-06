#
#   reactor/states/git/stage.sls
#   update salt masters git repos
#

git_stage_repo:
  local.state.sls:
    - tgt: 'http*.www.stage*'
    - arg:
      - 'reactor.states.git.stage-state'
