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
    - contents: {{ cert['key'] }}

/etc/tls/certs/{{ name }}.crowdrise.com.crt:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: {{ cert['cert'] }}

/etc/tls/certs/{{ name }}.crowdrise.com.crt.ca:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: {{ cert['certchain'] }}

/etc/tls/certs/{{ name }}.crowdrise.com.certchain:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - contents: |
      {{ cert['cert'] }}
      {{ cert['certchain'] }}

{% endfor %}
