#
#   crowdrise/blockdev/init.sls
#   make sure all presented SSDs are formatted ext4
#

{% for ssd in grains['SSDs'] %}
{%  if ssd != 'xvda' %}
/dev/{{ ssd }}1:
  blockdev.formatted:
    - fs_type: ext4
  mount.mounted:
    - name: /data{{ loop.index0 }}
    - device: /dev/{{ ssd }}1
    - fstype: ext4
    - mkmnt: True
    - opts:
      - async
      - noatime
      - barrier=0
    - require:
      - blockdev: /dev/{{ ssd }}1

/data{{ loop.index0 }}/mysqld:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: 750
    - makedirs: True
    - require:
      - mount: /dev/{{ ssd }}1
      - blockdev: /dev/{{ ssd }}1

/etc/rackspace-monitoring-agent.conf.d/data{{ loop.index0 }}-disk.yaml:
  file.managed:
    - source: salt://services/rackspace/files/monitoring/disk.yaml
    - template: jinja
    - makedirs: true
    - user: root
    - group: root
    - defaults:
      target_path: /data{{ loop.index0 }}

{%  endif %}
{% endfor %}




