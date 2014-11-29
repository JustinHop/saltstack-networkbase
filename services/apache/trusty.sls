#
#   services/apache/trusty.sls
#   Apache config for ubuntu 14.04
#

/etc/apache2:
  file.recurse:
    - source: salt://services/apache/files/{{ grains['oscodename'] }}/{{ grains['cluster'] }}/apache2
    - dir_mode: 755
    - file_mode: 644
    - template: jinja
    - include_empty: true
    - keep_symlinks: true

fix-apache-config-trusty:
  cmd.script:
    - source: salt://services/apache/scripts/fixit.sh
    - user: root
    - group: root
    - cwd: /root
