#
#   class/lb/init.sls
#   Nginx Reverse Proxy Class
#

include:
  - services/newrelic
  - services/ssl
  - nginx/ng

#
# Sysctl Tuning, Work on this more!
#

net.core.somaxconn:
  sysctl.present:
    - value: 65535

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
