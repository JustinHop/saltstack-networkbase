#
#   services/serverherald/init.sls
#   do stuff when new systems come up
#

#serverherald:
#  pip.installed:

git+https://gitlab.crowdrise.com/devops/serverherald.git#egg=serverherald:
  pip.installed





