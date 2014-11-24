#
#   class/master/init.sls
#   master things
#   prolly just a placeholder for class/master/product/whatever/init.sls
#


echo master > /etc/class:
  cmd.run:
    - user: root
