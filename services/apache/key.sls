#
#   services/apache/key.sls
#   place pki stuff
#


/etc/pki/tls/private/2016-wildcard.crowdrise.com.key:
  file.managed:
    - source: salt://services/apache/files/private
    - template: jinja
    - user: root
    - mode: 644
    - makedirs: true
    - watch_in:
      - service: apache

/etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt:
  file.managed:
    - source: salt://services/apache/files/cert
    - template: jinja
    - user: root
    - makedirs: true
    - watch_in:
      - service: apache

/etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt.ca:
  file.managed:
    - source: salt://services/apache/files/certchain
    - template: jinja
    - user: root
    - makedirs: true
    - watch_in:
      - service: apache
