#
#   excludes.sls
#   Place to disable states, should be temporary
#
#   shame on you
#

exclude:
  - sls: services/salt/minion
#  - sls: services/salt/master
