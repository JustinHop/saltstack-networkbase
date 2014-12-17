#
#   crowdrise/ssl/init.sls
#   crowdrise 2016 wildcard certs
#

/etc/pki/tls/private/wildcard.crowdrise.com.key:
  file.managed:
    - source: salt://crowdrise/ssl/files/private
    - template: jinja
    - user: root
    - mode: 644
    - makedirs: true

/etc/pki/tls/certs/wildcard.crowdrise.com.crt:
  file.managed:
    - source: salt://crowdrise/ssl/files/cert
    - template: jinja
    - user: root
    - makedirs: true

/etc/pki/tls/certs/wildcard.crowdrise.com.crt.ca:
  file.managed:
    - source: salt://crowdrise/ssl/files/certchain
    - template: jinja
    - user: root
    - makedirs: true

/etc/pki/tls/certs/wildcard.crowdrise.com.certchain:
  file.managed:
    - source: salt://crowdrise/ssl/files/fullcertchain
    - template: jinja
    - user: root
    - makedirs: true
