#
#   tops/ntp.sls
#   install ntp, should sync as well
#


base:
  '*':
    - base/ntp
