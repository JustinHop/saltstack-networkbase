
host.core2:
  host.present:
    - ip: 162.218.233.102
    - names:
      - core2.justinhoppensteadt.com
      - core2

host.core:
  host.present:
    - ip: 162.218.233.101
    - names:
      - core1.justinhoppensteadt.com
      - core.justinhoppensteadt.com
      - core1
      - core
      - mail.justinhoppensteadt.com
      - mail

host.www:
  host.present:
    - ip: 66.147.240.178
    - names:
      - www.justinhoppensteadt.com
      - justinhoppensteadt.com

hosts.sup1:
  host.present:
    - ip: 10.10.10.10
    - names: 
      - sup1.dc1.hnh
      - sup1

hosts.net1:
  host.present:
    - ip: 10.10.10.1
    - names:
      - net1.dc1.hnh
      - net1
