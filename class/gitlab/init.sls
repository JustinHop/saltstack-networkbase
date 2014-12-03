#
#   class/gitlab/init.sls
#   gitlabsystes
#

include:
  - services/ssl

exclude:
  - users
  - services/openssh
  - services/openssh/server

