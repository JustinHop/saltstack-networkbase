#
#   Check MK init for monitored hosts
#   services/check_mk/init.sls
#

checkmk:
  pkg.installed:
    - names:
      - xinetd
      - check-mk-agent
      - check-mk-agent-logwatch

/etc/xinetd.d/check_mk:
  file.managed:
    - source: salt://services/check_mk/files/checkmk.xinetd
    - user: root
    - group: root
    - mode: 644

{% if 'sysv' in grains %}
xinetd:
  service.running:
    - enable: True
{% endif %}


{% if 'systemd' in grains %}
include:
  - services/check_mk/systemd
{% endif %}
