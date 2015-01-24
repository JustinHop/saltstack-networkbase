#
#   excludes.sls
#   Place to disable states, should be temporary


#
#   shame on you
#

exclude:
  - sls: salt/minion
  - sls: salt/master
  - sls: services/sync
