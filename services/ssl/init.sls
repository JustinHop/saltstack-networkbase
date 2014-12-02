#
#   services/ssl/init.sls
#   crowdrise 2016 wildcard certs
#

/etc/pki/tls/private/2016-wildcard.crowdrise.com.key:
  file.managed:
    - source: salt://services/ssl/files/private
    - template: jinja
    - user: root
    - mode: 644
    - makedirs: true

/etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt:
  file.managed:
    - source: salt://services/ssl/files/cert
    - template: jinja
    - user: root
    - makedirs: true

/etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt.ca:
  file.managed:
    - source: salt://services/ssl/files/certchain
    - template: jinja
    - user: root
    - makedirs: true

/etc/pki/tls/certs/2016-wildcard.crowdrise.com.certchain:
  file.managed:
    - source: salt://services/ssl/files/fullcertchain
    - template: jinja
    - user: root
    - makedirs: true
