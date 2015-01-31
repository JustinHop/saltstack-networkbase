#
#   crowdrise/hostsfile/hosts.sls
#   include the hosts file
#   for debug
#


/etc/hosts.test:
  file.managed:
    - source: salt://crowdrise/hostsfile/files/hosts
    - template: jinja
    - user: root
