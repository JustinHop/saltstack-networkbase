#
#   base/ssl/init.sls
#   fancy loop over pillar data
#

{% for name, cert in  pillar.get('ssl', {}).items() %}

/etc/tls/private/{{ name }}.base.com.key:
  file.managed:
    - user: root
    - group: root
    - mode: 400
    - makedirs: true
    - contents: |
        {{ cert['key'] | indent(8) }}

/etc/tls/certs/{{ name }}.base.com.crt:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: |
        {{ cert['cert'] | indent(8) }}

/etc/tls/certs/{{ name }}.base.com.crt.ca:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: |
        {{ cert['certchain'] | indent(8) }}

/etc/tls/certs/{{ name }}.base.com.certchain:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: |
        {{ cert['cert'] | indent(8) }}
        {{ cert['certchain'] | indent(8) }}

{% endfor %}
