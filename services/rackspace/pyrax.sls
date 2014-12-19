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
  pkg.installed:
      - name: python-pip
  pip.installed:
    - name: pyrax
    - require:
      - pkg: pyrax_setup
      - file: pyraxrc

setup_domain:
  rackspace.dns_zone_exists:
    - name: crowdrise.io
    - email_address: noreply@crowdrise.com
    - ttl: 300
    - require:
      - pip: pyrax_setup
      - file: pyraxrc

setup_records2:
  rackspace.dns_record_exists:
    - zone_name: crowdrise.io
    - name: {{ grains['fqdn'] }}
    - record_type: "A"
    - data: {{ grains['fqdn_ip4']|first }}
    - require:
      - rackspace: setup_domain
      - file: pyraxrc
