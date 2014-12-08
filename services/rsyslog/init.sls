#
#   services/rsyslog/init.sls
#   rsyslog client for log aggergation
#


rsyslog-client:
  pkg.installed:
    - pkgs:
      - rsyslog
      - rsyslog-relp
