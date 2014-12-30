#
#   product/percona/init.sls
#   install percona stuff
#


include:
  - services/percona
  - services/newrelic
  - services/rackspace
