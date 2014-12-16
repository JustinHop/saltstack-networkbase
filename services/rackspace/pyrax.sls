#
#   services/rackspace/pyrax.sls
#   setup services using rackspace module
#


pyrax_setup:
  pkg.installed:
      - name: python-pip
  pip.installed:
    - name: pyrax
    - require:
      - pkg: pyrax_setup

setup_domain:
  rackspace.dns_zone_exists:
    - name: {{ grains['business'] }}.{{ grains['tld'] }}
    - email_address: noreply@crowdrise.com
    - ttl: 300
    - require:
      - pip: pyrax_setup

setup_records2:
  rackspace.dns_record_exists:
    - zone_name: {{ grains['business'] }}.{{ grains['tld'] }}
    - name: {{ grains['fqdn'] }}
    - record_type: A
    - data: {{ grains['fqdn_ip4'] }}
    - require:
      - rackspace: setup_domain
