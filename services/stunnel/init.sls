stunnel:
  pkg:
    - installed
    - name: stunnel4
#  service.running:
#    - name: stunnel4
#    - watch:
#      - file: /etc/stunnel/*
#      - pkg: stunnel4


/etc/default/stunnel4:
  file.managed:
    - source: salt://stunnel/files/stunnel-default
    - user: root
    - group: root
    - mode: 644

