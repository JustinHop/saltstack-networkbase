#
#   class/gitlab/init.sls
#   gitlabsystes
#

include:
  - base/ssl

exclude:
  - users
  - services/openssh
  - services/openssh/server

