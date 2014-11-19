#
#   class/varnish/init.sls
#   to include services/varnish
#

include:
  - services/varnish


echo varnish > /etc/class:
  cmd.run
