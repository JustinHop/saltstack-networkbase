#
#   class/http/init.sls
#   Crowdrise Frontend Webservers
#

include:
  - services/newrelic
  - services/apache
  - crowdrise/ssl

frontend-webserver:
  pkg.installed:
    - names:
      - apache2
      - apache2-mpm-prefork
      - mysql-client
      - mysql-client-5.6
      - mysql-client-core-5.6
      - php-apc
      - php5
      - php5-cli
      - php5-common
      - php5-curl

net.core.somaxconn:
  sysctl.present:
    - value: 8192

net.core.rmem_max:
  sysctl.present:
    - value: 8388608

net.core.rmem_default:
  sysctl.present:
    - value: 65536

net.core.tcp_rmem:
    sysctl.present:
          - value: 4096 87380 8388608

net.core.wmem_max:
  sysctl.present:
    - value: 8388608

net.core.wmem_default:
  sysctl.present:
    - value: 65536

net.core.tcp_wmem:
    sysctl.present:
          - value: 4096 87380 8388608

net.core.tcp_mem:
    sysctl.present:
          - value: 8388608 8388608 8388608

net.ipv4.route.flush:
  sysctl.present:
    - value: 1
