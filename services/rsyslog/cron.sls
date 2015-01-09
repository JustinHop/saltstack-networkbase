#
#   services/rsyslog/cron.sls
#   daily log compressing log thingy
#

pxz:
  pkg.installed


find /data -type f -mtime +0 \( \! -name '*.xz' \) | nice xargs pxz -v {} | logger -p cron.info:
  cron.present:
    - identifier: LogRotate
    - user: syslog
    - group: syslog
    - minute: 15
    - hour: 3
