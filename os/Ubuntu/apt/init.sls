#
#   os/Ubuntu/apt/init.sls
#   Home of the repos
#

#/etc/apt/sources.list:
#  file.managed:
#    - source: salt://os/Ubuntu/apt/files/sources.list
#    - template: jinja
#    - user: root
#    - group: root
#    - mode: 644

#sudo sh -c 'echo "deb http://stable.packages.cloudmonitoring.rackspace.com/ubuntu-14.04-x86_64 cloudmonitoring main" > /etc/apt/sources.list.d/rackspace-monitoring-agent.list'
# https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc



