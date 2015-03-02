

/usr/local/bin:
  file.recurse:
    - source: salt://base/bin/bin
    - user: root
    - group: root
    - file_mode: 755
    - dir_mode: 755
