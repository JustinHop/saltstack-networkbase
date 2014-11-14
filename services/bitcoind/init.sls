#
#  Bitcoind init
#  services/bitcoind/init.sls
#

#base:
#  pkgrepo.managed:
#    - humanname: Logstash PPA
#    - name: deb http://ppa.launchpad.net/wolfnet/logstash/ubuntu precise main
#    - dist: precise
#    - file: /etc/apt/sources.list.d/logstash.list
#    - keyid: 28B04E4A
#    - keyserver: keyserver.ubuntu.com
#    - require_in:
#      - pkg: logstash
#

bitcoin-stable:
  pkgrepo.managed:
    - humanname: Bitcoin - Stable Channel
    - name: deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu trusty main
    - file: /etc/apt/sources.list.d/bitcoin.list
    - keyid: 8842CE5E
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: bitcoind

bitcoind:
  pkg.installed:
    - names:
      - bitcoind
      - python-zope.interface
      - python-twisted
      - python-twisted-web
      - python-pyasn1
      - python-pyasn1-modules
      - ntp
      - git
      - build-essential
      - libssl-dev
      - libdb-dev
      - libdb++-dev
      - libboost-all-dev
      - libqrencode-dev
      - libcurl4-openssl-dev
      - libwxgtk3.0-dev
      - libglib2.0-dev
    

/etc/init/bitcoind.conf:
  file.managed:
    - source: salt://services/bitcoind/files/bitcoind.conf
    - user: root
    - group: root
    - mode: 644

/etc/init/devcoind.conf:
  file.managed:
    - source: salt://services/bitcoind/files/devcoind.conf
    - user: root
    - group: root
    - mode: 644

/etc/init/namecoind.conf:
  file.managed:
    - source: salt://services/bitcoind/files/namecoind.conf
    - user: root
    - group: root
    - mode: 644

/etc/init/ixcoind.conf:
  file.managed:
    - source: salt://services/bitcoind/files/ixcoind.conf
    - user: root
    - group: root
    - mode: 644

/etc/init/i0coind.conf:
  file.managed:
    - source: salt://services/bitcoind/files/i0coind.conf
    - user: root
    - group: root
    - mode: 644

/etc/init/p2poold.conf:
  file.managed:
    - source: salt://services/bitcoind/files/p2poold.conf
    - user: root
    - group: root
    - mode: 644


p2pool:
  git.latest:
    - name: git://github.com/forrestv/p2pool.git
    - target: /usr/local/p2pool

stratum-mining-proxy:
  git.latest:
    - name: https://github.com/CryptoManiac/stratum-mining-proxy.git
    - target: /usr/local/stratum-mining-proxy

litecoin:
  git.latest:
    - name: https://github.com/litecoin-project/litecoin.git
    - target: /usr/local/litecoin
  cmd.wait:
    - name: make -j5 -f makefile.unix FOR_LITECOIN=1 USE_UPNP= USE_QRCODE=1 USE_IPV6=1 && strip litecoind
    - cwd: /usr/local/litecoin/src
    - watch:
      - git: litecoin

namecoin:
  git.latest:
    - name: git://github.com/namecoin/namecoin.git
    - target: /usr/local/namecoin
  cmd.wait:
    - name: make -j5 FOR_NAMECOIN=1 USE_UPNP= USE_QRCODE=1 USE_IPV6=1 namecoind && strip namecoind
    - cwd: /usr/local/namecoin/src
    - watch:
      - git: namecoin

devcoin:
  git.latest:
    - name: git://github.com/knotwork/old-devcoind.git
    - target: /usr/local/devcoin
  cmd.wait:
    - name: make -j5 -f makefile.unix FOR_DEVCOIN=1 USE_UPNP= USE_QRCODE=1 USE_IPV6=1 devcoind && strip devcoind
    - cwd: /usr/local/devcoin/src
    - watch:
      - git: devcoin

ixcoin:
  git.latest:
    - name: https://github.com/ixcoin/ixcoin.git
    - target: /usr/local/ixcoin
  cmd.wait:
    - name: make -j5 -f makefile.unix FOR_IXCOIN=1 USE_UPNP= USE_QRCODE=1 USE_IPV6=1 ixcoind && strip ixcoind
    - cwd: /usr/local/ixcoin/src
    - watch:
      - git: ixcoin

i0coin:
  git.latest:
    - name: git://github.com/RyanEager/i0coin
    - target: /usr/local/i0coin
  cmd.wait:
    - name: make -j5 -f makefile.unix FOR_I0COIN=1 USE_UPNP= USE_QRCODE=1 USE_IPV6=1 i0coind && strip i0coind
    - cwd: /usr/local/i0coin/src
    - watch:
      - git: i0coin

stratum:
  git.latest:
    - name: git://github.com/slush0/stratum-mining-proxy.git
    - target: /usr/local/stratum
  module.run:
    - name: pip.install
    - upgrade: True
    - pkgs:
      - stratum
      - service_identity
      - Twisted



#  cmd.wait:
#    - name: make install
#    - cwd: /opt/foo
#    - watch:
#      - git: my-project
