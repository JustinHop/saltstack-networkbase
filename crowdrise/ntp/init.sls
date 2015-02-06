#
#   crowdrise/ntp/init.sls
#   stuff for network time protocol
#

include:
  - ntp/ng

xen.independent_wallclock:
  sysctl.present:
    - value: 1
