#
#   Python init
#   base/full/python/init.sls
#

python-packages:
  pkg.installed:
    - names:
      - python-pip
      - python-dev
      - swig
      - libssl-dev
  module.run:
    - name: pip.install
    - download_cache: /var/cache/salt-pip
{%- if salt['pillar.get']('upgrade') %}
    - upgrade: True
{%- endif %}
    - pkgs:
      - docopt
      - cookiecutter
      - cookiecutter-docopt
      - mccabe
      - flake8
      - pexpect
      - python-apt
      - pip-tools
      - psutil

/var/cache/salt-pip:
  file:
    - directory
    - makedirs: True

