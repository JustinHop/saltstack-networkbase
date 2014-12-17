#
#   services/varnish/stunnel.sls
#   configuration for stunnel wrappers for varnish
#

include:
  - crowdrise/ssl

stunnel4:
  pkg:
    - installed
  service:
    - running

