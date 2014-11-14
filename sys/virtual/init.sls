

{%- if salt['pillar.get']('full_service_container') %}
containers:
  pkg.installed:
    - force_yes: true
    - names:
      - systemd
      - systemd-sysv

containers-rmpkg:
  pkg.removed:
    - force_yes: true
    - names:
      - sysvinit
      - dmidecode

udev:
  service:
    - disabled

/etc/systemd/system/systemd-udevd.service:
  file.symlink:
    - target: /dev/null

/etc/systemd/system/systemd-udevd-control.socket:
  file.symlink:
    - target: /dev/null

/etc/systemd/system/systemd-udevd-kernel.socket:
  file.symlink:
    - target: /dev/null

/etc/systemd/system/proc-sys-fs-binfmt_misc.automount:
  file.symlink:
    - target: /dev/null

{% endif %}
