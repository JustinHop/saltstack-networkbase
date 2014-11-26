{% from "services/varnish/map.jinja" import varnish with context %}
#
#   services/varnish/conf.sls
#   copy over config files for varnish depending on cluster
#


{%  if 'cluster' in grains %}
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

{%    for cluster in grains['cluster'] %}
{%      if cluster == 'prod' %}

touch /tmp/test:
  cmd:
    - run

/etc/varnish:
  file.directory:
    - root: beanstalk
    - group: beanstalk
    - mode: 0775
    - require:
      - user: beanstalk
  git.latest:
    - name: git@crowdrise.git.beanstalkapp.com:/crowdrise/varnish.git
    - target: master
    - user: beanstalk
    - identity: /home/beanstalk/.ssh/id_rsa
    - require:
      - pkg: git
      - user: beanstalk
{%      elif cluster == 'load' %}
/etc/varnish:
  file.directory:
    - root: beanstalk
    - group: beanstalk
    - mode: 0775
    - require:
      - user: beanstalk
  git.latest:
    - name: git@crowdrise.git.beanstalkapp.com:/crowdrise/varnish.git
    - target: loadtest
    - user: beanstalk
    - identity: /home/beanstalk/.ssh/id_rsa
    - require:
      - pkg: git
      - user: beanstalk
{%      else %}
# Below we deploy the vcl files and we trigger a reload of varnish
/etc/varnish/default.vcl-{{ grains['cluster'] }}:
  file:
    - managed
    - name: /etc/varnish/default.vcl
    - makedirs: true
    - source:
      - salt://services/varnish/files/{{ grains['cluster'] }}/etc/varnish/default.vcl
    - template: jinja
    - require:
      - pkg: varnish
    - watch_in:
      - service: varnish

{%      endif %}
{%    endfor %}
{%  endif %}

