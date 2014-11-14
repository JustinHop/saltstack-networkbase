/etc/apt/sources.list:
  file.managed:
    - source: salt://os/Debian/apt/files/sources.list
    - template: jinja
    - user: root
    - group: root
    - mode: 644
