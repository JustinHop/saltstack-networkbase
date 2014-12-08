#
# class/master/product/salt/init.sls
# master.salt instances
#

include:
  - salt/master

salt '*' test.ping:
  cron.present:
    - identifier: SaltConnect
    - user: root
    - minute: '*/10'
