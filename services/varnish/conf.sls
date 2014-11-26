{% from "services/varnish/map.jinja" import varnish with context %}
#
#   services/varnish/conf.sls
#   copy over config files for varnish depending on cluster
#



{%  if 'cluster' in grains %}
include:
  - services/varnish/{{ grains['cluster'] }}

#{%    for cluster in grains['cluster'] %}
#{%      if cluster == 'prod' %}
#
#echo {{ grains['cluster'] }} >> /tmp/test:
#  cmd:
#    - run
#
#{%      elif cluster == 'load' %}
#/etc/varnish:
#  file.directory:
#    - root: beanstalk
#    - group: beanstalk
#    - mode: 0775
#    - require:
#      - user: beanstalk
## Below we deploy the vcl files and we trigger a reload of varnish
#/etc/varnish/default.vcl-{{ grains['cluster'] }}:
#  file:
#    - managed
#    - name: /etc/varnish/default.vcl
#    - makedirs: true
#    - source:
#      - salt://services/varnish/files/{{ grains['cluster'] }}/etc/varnish/default.vcl
#    - template: jinja
#    - require:
#      - pkg: varnish
#    - watch_in:
#      - service: varnish
##
##  git.latest:
##    - name: git@crowdrise.git.beanstalkapp.com:/crowdrise/varnish.git
##    - target: loadtest
##    - user: beanstalk
##    - identity: /home/beanstalk/.ssh/id_rsa
##    - require:
##      - pkg: git
##      - user: beanstalk
#{%      else %}
#{%      endif %}
#{%    endfor %}
#{%  endif %}
#
