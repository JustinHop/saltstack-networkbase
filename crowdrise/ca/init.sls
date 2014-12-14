
/usr/local/share/ca-certificates:
  file.recurse:
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - source: salt://crowdrise/ca/files

/usr/sbin/update-ca-certificates:
  cmd.run:
    - watch:
      - file: /usr/local/share/ca-certificates


