
chkrootkit:
  pkg:
    - installed


/etc/chkrootkit.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - source: salt://base/full/chkrootkit/files/chkrootkit.conf
    - require:
      - pkg: chkrootkit
