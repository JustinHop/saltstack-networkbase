

/usr/local/bin:
  file.recurse:
    - source: salt://crowdrise/bin/bin
    - user: root
    - group: root
    - file_mode: 755
    - dir_mode: 755
