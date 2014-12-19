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
{%  endif %}
{% endfor %}




