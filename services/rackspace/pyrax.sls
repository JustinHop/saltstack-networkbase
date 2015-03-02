#
#   services/rackspace/pyrax.sls
#   setup services using rackspace module
#

pyraxrc:
  file.managed:
    - source: salt://services/rackspace/files/pyraxrc
    - name: /root/.pyrax.cfg
    - template: jinja
    - user: root
    - group: root


pyrax_setup:
  pip.installed:
    - name: pyrax
    - require:
      - file: pyraxrc
      - pkg: python-dev
      - pkg: build-essential

setup_domain:
  rackspace.dns_zone_exists:
    - name: base.com
    - email_address: noreply@base.com
    - ttl: 300
    - require:
      - pip: pyrax
      - file: pyraxrc

setup_records2:
  rackspace.dns_record_exists:
    - zone_name: base.com
    - name: {{ grains['fqdn'] }}
    - record_type: "A"
    - data: {{ grains['fqdn_ip4']|first }}
    - comment: salt pyrax added system record
    - require:
      - pip: pyrax
      - file: pyraxrc
      - rackspace: setup_domain

