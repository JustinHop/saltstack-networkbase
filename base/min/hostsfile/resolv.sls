# Resolver Configuration
/etc/resolv.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://base/min/hostsfile/files/resolv.conf
    - template: jinja
    - defaults:
        nameservers: ['173.203.4.9', '173.203.4.8']
        searchpath: 'crowdrise.io'


