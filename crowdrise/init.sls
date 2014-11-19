#
#   crowdrise/init.sls
#   Includes for crowdrise
#

include:
  - base/min/hostsfile/resolv



crowdrise-nopkg:
  pkg.removed:
    - pkgs: ['nano', 'resolvconf']

