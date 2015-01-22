#
#   services/salt/minion.sls
#   only take minion.d files from here
#   less breaking
#

/etc/salt/minion.d:
  file.recurse:
    - source: salt://services/salt/files/minion
    - user: root
    - group: root
    - mode: 644
    - template: jinja
