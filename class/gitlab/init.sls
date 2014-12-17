#
#   class/gitlab/init.sls
#   gitlabsystes
#

include:
  - crowdrise/ssl

exclude:
  - users
  - services/openssh
  - services/openssh/server

