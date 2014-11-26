#
#   services/varnish/prod.sls
#   prod varnish config, booyakasha
#

/etc/default/varnish:
  file:
    - managed
    - makedirs: True
    - source:
      - salt://services/varnish/files/{{ grains['cluster'] }}/etc/default/varnish
    - template: jinja
    - require:
      - pkg: varnish
    - require_in:
      - service: varnish

/etc/varnish:
  file.directory:
    - user: beanstalk
    - mode: 0775
    - require:
      - user: beanstalk
  git.latest:
    - name: git@crowdrise.git.beanstalkapp.com:/crowdrise/varnish.git
    - rev: master
    - target: /etc/varnish
    - user: beanstalk
    - identity: /home/beanstalk/.ssh/id_rsa
    - force: true
    - require:
      - pkg: git
      - user: beanstalk

/etc/varnish/secret:
  file:
    - managed
    - makedirs: true
    - source:
      - salt://services/varnish/files/{{ grains['cluster'] }}/etc/varnish/secret
    - template: jinja
    - require:
      - pkg: varnish
    - watch_in:
      - service: varnish

