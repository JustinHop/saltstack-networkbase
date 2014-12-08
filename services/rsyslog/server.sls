#
#   services/rsyslog/server.sls
#   rsyslog server for log aggergation
#


rsyslog-server:
  pkg.installed:
    - pkgs:
      - rsyslog-doc
