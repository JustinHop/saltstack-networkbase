#
#   class/http/product/front/init.sls
#   Crowdrise Frontend Webservers
#

include:
  - services/newrelic

frontend-webserver:
  pkg.installed:
    - names:
      - apache2
      - apache2-mpm-prefork
      - mysql-client
      - mysql-client-5.5
      - mysql-client-core-5.5
      - php-apc
      - php5
      - php5-cli
      - php5-common
      - php5-curl
      - php5-mysql

