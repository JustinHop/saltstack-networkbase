#
#   tops/ntp.sls
#   install ntp, should sync as well
#


base:
  '*':
    - ntp/ng
