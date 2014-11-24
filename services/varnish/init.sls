{% from "services/varnish/map.jinja" import varnish with context %}

include:
  - services/varnish/conf
  - services/varnish/newrelic

varnish:
  pkg:
    - installed
    - name: {{ varnish.pkg }}
    {% if varnish.version is defined %}
    - version: {{ varnish.version }}
    {% endif %}
  service:
    - running
    - name: {{ varnish.service }}
    - enable: True
    - reload: True
    - require:
      - pkg: varnish

