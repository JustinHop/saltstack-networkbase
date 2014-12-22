#
#   services/apache/cron.sls
#   Prod Crontabs
#


{%  if grains['class_instance']|int == "1"|int %}
wepay-cron-prod:
  cron.present:
    - name: php /var/www/trunk/htdocs/application/cron/cron_generic.php prod /cron/wepay_tips
    - minute: */2
    - user: www-data
    - identifier: Process Queued Wepay Donation Tips Every 2 Minutes Prod

wepay-cron-dev:
  cron.present:
    - name: php /var/www/trunk/htdocs/application/cron/cron_generic.php dev /cron/wepay_tips
    - minute: */2
    - user: www-data
    - identifier: Process Queued Wepay Donation Tips Every 2 Minutes Dev

{%  endif %}
