#
#   services/varnish/stunnel.sls
#   configuration for stunnel wrappers for varnish
#

include:
  - base/ssl

stunnel4:
  pkg:
    - installed
  service:
    - running

