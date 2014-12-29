#
#   services/apache/cron.sls
#   Prod Crontabs
#

{%- if grains['class_instance']|int <= "2"|int %}
wepay-cron-prod-{{ grains['class_instance'] }}:
  cron.present:
    - name: php /var/www/trunk/application/cron/cron_generic.php prod /cron/wepay_tips | logger -p cron.info
{%-   if grains['class_instance']|int == "1"|int %}
    - minute: '*/4'
{%-   else %}
    - minute: '2-58/4'
{%-   endif %}
    - user: www-data
    - identifier: Process Queued Wepay Donation Tips Every 2 Minutes Prod

wepay-cron-dev-{{ grains['class_instance'] }}:
  cron.present:
    - name: php /var/www/trunk/application/cron/cron_generic.php dev /cron/wepay_tips | logger -p cron.info
{%-   if grains['class_instance']|int == "1"|int %}
    - minute: '*/4'
{%-   else %}
    - minute: '2-58/4'
{%-   endif %}
    - user: www-data
    - identifier: Process Queued Wepay Donation Tips Every 2 Minutes Dev

wepay-ping-cron-prod-{{ grains['class_instance'] }}:
  cron.present:
    - name: php /var/www/trunk/application/cron/cron_generic.php prod /cron/wepay_pings | logger -p cron.info
{%-   if grains['class_instance']|int == "1"|int %}
    - minute: '*/2'
{%-   else %}
    - minute: '1-59/2'
{%-   endif %}
    - user: www-data
    - identifier: Process Queued Wepay Prod Pings

wepay-ping-cron-dev-{{ grains['class_instance'] }}:
  cron.present:
    - name: php /var/www/trunk/application/cron/cron_generic.php dev /cron/wepay_pings | logger -p cron.info
{%-   if grains['class_instance']|int == "1"|int %}
    - minute: '*/2'
{%-   else %}
    - minute: '1-59/2'
{%-   endif %}
    - user: www-data
    - identifier: Process Queued Wepay Dev Pings

{%  endif %}
