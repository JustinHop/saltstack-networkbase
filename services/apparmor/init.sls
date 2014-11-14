
apparmor:
  pkg.installed:
    - names:
      - apparmor
      - apparmor-utils
      - apparmor-profiles

{% if 'virtual_subtype' not in grains %}
/etc/default/grub:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - source: salt://services/apparmor/files/grub-default

/usr/sbin/update-grub2:
  cmd.run:
    - watch:
      - file: /etc/default/grub
{% endif %}
