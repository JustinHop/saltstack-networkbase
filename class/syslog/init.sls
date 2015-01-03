#
#   class/syslog/init.sls
#   Handle syslog systems
#

include:
  - crowdrise/blockdev
  - services/rsyslog/server
