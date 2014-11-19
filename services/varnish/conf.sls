#
#   services/varnish/conf.sls
#   copy over config files for varnish depending on cluster
#

include:
  - varnish

/etc/default/varnish:
  file.recurse:
    - source:
      - salt://services/varnish/files/{{ grain['cluster'] }}/etc/default
    - template: jinja
    - require:
      - pkg: varnish
    - require_in:
      - service: varnish

# Below we deploy the vcl files and we trigger a reload of varnish
/etc/varnish/default.vcl:
  file:
    - managed
    - makedirs: true
    - source:
      - salt://services/varnish/files/{{ grain['cluster'] }}/etc/varnish/default.vcl
    - template: jinja
    - require:
      - pkg: varnish
    - watch_in:
      - service: varnish

/etc/varnish/secret:
  file:
    - managed
    - makedirs: true
    - source:
      - salt://services/varnish/files/{{ grain['cluster'] }}/etc/varnish/secret
    - template: jinja
    - require:
      - pkg: varnish
    - watch_in:
      - service: varnish

