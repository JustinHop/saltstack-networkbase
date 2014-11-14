# Resolver Configuration
/etc/resolv.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://base/min/hostsfile/files/resolv.conf
    - template: jinja
    - defaults:
        nameservers: ['10.10.10.1']
        searchpath: 'dc1.hnh justinhoppensteadt.com'


