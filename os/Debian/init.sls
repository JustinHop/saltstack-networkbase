#
#   os/Debian/init.sls
#

include:
  - os/Debian/apt
  - os/Debian/consollabs
  - services/check_mk


deb-pkgs:
  pkg.installed:
    - names:
      - dnsutils

