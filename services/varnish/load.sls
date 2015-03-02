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
    - group: beanstalk
    - mode: 0775
    - require:
      - user: beanstalk
    - require_in:
      - varnish-git

varnish-git:
  git.latest:
    - name: git@base.git.beanstalkapp.com:/base/varnish.git
    - rev: loadtest
    - target: /etc/varnish
    - user: root
    - identity: /home/beanstalk/.ssh/id_rsa
    - force: true
    - require:
      - pkg: git
      - file: /etc/varnish

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

