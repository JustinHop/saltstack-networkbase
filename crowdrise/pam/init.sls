

pam:
  pkg:
    - installed
    - names:
      - libpam-script
      - libpam-cgroup
      - libpam-ck-connector
      - libpam-cap
      - libwww-perl
  file.managed:
    - name: /etc/pam.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://pam/files/pam.conf

/etc/pam.d:
  file.recurse:
    - name: 
    - source: salt://pam/files/pam.d
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
