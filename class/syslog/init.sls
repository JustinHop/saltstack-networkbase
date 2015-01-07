#
#   class/syslog/init.sls
#   Handle syslog systems
#

include:
  - services/rsyslog/server
