#
#   services/apache/cron.sls
#   Prod Crontabs
#


{%  for CI in grains['class_instance'] %}
{%    if CI == "1" %}
wepay-cron-prod:
  cron.present:
    - name: /var/www/vhosts/www.crowdrise.com/htdocs/application/cron/cron_generic.php prod /cron/wepay_tips
    - minute: */2
    - user: www-data
    - identifier: Process Queued Wepay Donation Tips Every 2 Minutes Prod

wepay-cron-dev:
  cron.present:
    - name: /var/www/vhosts/www.crowdrise.com/htdocs/application/cron/cron_generic.php dev /cron/wepay_tips
    - minute: */2
    - user: www-data
    - identifier: Process Queued Wepay Donation Tips Every 2 Minutes Dev

{%    endif %}
{%  endfor %}
