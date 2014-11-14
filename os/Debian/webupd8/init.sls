webupd8:
  pkgrepo.managed:
    - humanname: WebUpD8 PPA
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/webupd8team.list
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: logstash
