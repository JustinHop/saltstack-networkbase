

/usr/local/bin:
  file.recurse:
    - source: salt://basebin/bin
    - user: root
    - group: root
    - file_mode: 755
    - dir_mode: 755
