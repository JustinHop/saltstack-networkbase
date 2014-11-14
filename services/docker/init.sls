
docker:
  pkgrepo.managed:
    - humanname: Docker.io Virtualization
    - name: deb http://get.docker.io/ubuntu docker main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: A88D21E9 
    - keyserver: keyserver.ubuntu.com
    - disabled: False
    - require_in:
      - pkg: lxc-docker
  pkg.installed:
    - name: lxc-docker
{%- if salt['pillar.get']('upgrade') %}
  module.run:
    - name: pip.install
    - upgrade: True
    - download_cache: /var/cache/salt-pip
    - pkgs:
      - git+https://github.com/dotcloud/docker-py.git
{%- endif %}
