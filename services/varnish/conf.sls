{% from "services/varnish/map.jinja" import varnish with context %}
#
#   services/varnish/conf.sls
#   copy over config files for varnish depending on cluster
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

# Below we deploy the vcl files and we trigger a reload of varnish
/etc/varnish/default.vcl:
  file:
    - managed
    - makedirs: true
    - source:
      - salt://services/varnish/files/{{ grains['cluster'] }}/etc/varnish/default.vcl
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
      - salt://services/varnish/files/{{ grains['cluster'] }}/etc/varnish/secret
    - template: jinja
    - require:
      - pkg: varnish
    - watch_in:
      - service: varnish

