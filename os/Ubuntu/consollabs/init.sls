
consollabsrepo:
  pkgrepo.managed:
    - humanname: ConSol Labs
    - name: deb http://labs.consol.de/repo/stable/ubuntu {{ grains['oscodename']
    }} main
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/consollabs.list
    - keyid: F8C1CA08A57B9ED7
    - keyserver: keys.gnupg.net

