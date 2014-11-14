

etc_defaults:
  file.recurse:
    - name: /etc/default
    - source: salt://base/full/default/files
    - user: root
    - group: adm
    - file_mode: 750
    - group_mode: 640

