# Resolver Configuration
/etc/resolv.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://base/min/hostsfile/files/resolv.conf
    - template: jinja
    - defaults:
        domains: {{ grains['business'] }}.{{ grains ['tld'] }}
        nameservers:
          - 173.203.4.9
          - 173.203.4.8
        searchpaths:
          - {{ grains['product'] }}.{{ grains['cluster'] }}{{ grains['cluster_instance'] }}.{{ grains['business'] }}.{{ grains ['tld'] }}
          - {{ grains['cluster'] }}{{ grains['cluster_instance'] }}.{{ grains['business'] }}.{{ grains ['tld'] }}
          - {{ grains['business'] }}.{{ grains ['tld'] }}


