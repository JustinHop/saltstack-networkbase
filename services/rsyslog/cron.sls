#
#   services/rsyslog/cron.sls
#   daily log compressing log thingy
#

pxz:
  pkg.installed


find /data/$(date --date="yesterday" +%F | tr - /) -type f | xargs pxz -v | logger -p cron.info:
  cron.present:
    - user
