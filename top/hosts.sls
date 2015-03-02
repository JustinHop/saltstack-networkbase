#
#   tops/hosts.sls
#   hosts only
#

base:

  '*':
    - base/hostsfile
