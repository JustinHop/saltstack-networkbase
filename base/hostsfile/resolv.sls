# Resolver Configuration
{% if 'nameservers' in pillar %}
/etc/resolv.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://basehostsfile/files/resolv.conf
    - template: jinja
    - defaults:
        domain: {{ grains['business'] }}.{{ grains ['tld'] }}
        nameservers:
{%    for nameserver in pillar['nameservers'] %}
          - {{ nameserver }}
{%    endfor %}
        searchpaths:
          - {{ grains['product'] }}.{{ grains['cluster'] }}{{ grains['cluster_instance'] }}.{{ grains['business'] }}.{{ grains ['tld'] }}
          - {{ grains['cluster'] }}{{ grains['cluster_instance'] }}.{{ grains['business'] }}.{{ grains ['tld'] }}
          - {{ grains['business'] }}.{{ grains ['tld'] }}
{% endif %}

