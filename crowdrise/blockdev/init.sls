#
#   crowdrise/blockdev/init.sls
#   make sure all presented SSDs are formatted ext4
#

{% for count, ssd enumerate(grains['SSDs']) %}
{%  if ssd != 'xvda' %}
/dev/{{ ssd }}1:
  blockdev.formatted:
    - fs_type: ext4
  mount.mounted:
    - name: /data{{ count }}
    - fstype: ext4
    - mkmnt: True
    - opts:
      - async
      - noatime
{%  endif %}
{% endfor %}




