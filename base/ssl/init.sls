#
#   crowdrise/ssl/init.sls
#   fancy loop over pillar data
#

{% for name, cert in  pillar.get('ssl', {}).items() %}

/etc/tls/private/{{ name }}.crowdrise.com.key:
  file.managed:
    - user: root
    - group: root
    - mode: 400
    - makedirs: true
    - contents: |
        {{ cert['key'] | indent(8) }}

/etc/tls/certs/{{ name }}.crowdrise.com.crt:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: |
        {{ cert['cert'] | indent(8) }}

/etc/tls/certs/{{ name }}.crowdrise.com.crt.ca:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: |
        {{ cert['certchain'] | indent(8) }}

/etc/tls/certs/{{ name }}.crowdrise.com.certchain:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: |
        {{ cert['cert'] | indent(8) }}
        {{ cert['certchain'] | indent(8) }}

{% endfor %}
