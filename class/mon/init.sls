#
#   class/mon/init.sls
#   monitor class
#

include:
  - services/newrelic
  - services/nginx

{%  for id, lb in salt['pillar.get']('lb', {}).items() %}

echo {{ id }}:
  cmd.run

{%    if lb.name is defined and id is defined %}
/etc/rackspace-monitoring-agent.conf.d/loadbalancer-{{ lb.name }}.yaml:
  file.managed:
    - source: salt://class/mon/files/loadbalancer.yaml
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      target_name: {{ lb.name }}
      target_id: {{ id }}
{%    endif %}
{%  endfor %}

/var/www/vhosts/mon.base.com/htdocs:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True

nodeinstall:
  cmd.script:
    - source: https://deb.nodesource.com/setup
    - user: root
    - group: root
    - creates: /etc/apt/sources.list.d/nodesource.list
  pkg.installed:
    - pkgs:
      - phantomjs
      - xvfb
      - elinks
      - openjdk-7-jre-headless
      - openjdk-7-jre-zero

sitespeed.io:
  npm.installed:
    - require:
      - cmd: nodeinstall

sitespeed.io -u https://www.base.com --gpsiKey AIzaSyDTFQvk7oV7R11-yOl2wdGTdB9tI5QXPv4:
  cron.present:
    - identifier: SiteSpeed https://www.base.com
    - cwd: /var/www/vhosts/mon.base.com
    - user: www-data
    - minute: '*/10'
    
