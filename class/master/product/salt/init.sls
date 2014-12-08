#
# class/master/product/salt/init.sls
# master.salt instances
#

{%- if  "salt.master".replace(" ", "_") in states %}
include:
  - salt/master
{%- endif %}

salt '*' test.ping:
  cron.present:
    - identifier: SaltConnect
    - user: root
    - minute: '*/10'
