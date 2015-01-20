#
#   services/openssh/default.sls
#   reset openssh to defaults
#

/etc/ssh/sshd_config:
  - user: root
  - group: root
  - source: salt://services/openssh/files/sshd_config.default
