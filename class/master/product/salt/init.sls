#
# class/master/product/salt/init.sls
# master.salt instances
#


include:
  - salt/master
  - services/sync

