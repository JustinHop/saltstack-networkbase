#
#   class/lb/init.sls
#   Nginx Reverse Proxy Class
#

include:
  - services/newrelic
  - crowdrise/ssl
  - nginx/ng

nginx-config:
  pkgrepo.managed:
    - ppa: crowdrise/nginx-builds
    - keyid: 75FC36CE
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - name: nginx-light
    - refresh: true

openssl dhparam -out /etc/nginx/dhparam.pem 4096:
  cmd.run:
    - user: root
    - group: root
    - creates: /etc/nginx/dhparam.pem

/etc/nginx/naxsi.rules:
  file.managed:
    - user: root
    - group: root
    - source: salt://class/lb/files/naxsi.rules

/etc/nginx/naxsi_core.rules:
  file.managed:
    - user: root
    - group: root
    - source: salt://class/lb/files/naxsi_core.rules

/etc/nginx/htpasswd-showcase:
  file.managed:
    - user: root
    - group: root
    - contents: |
        crowdrise:$apr1$TgiH7/c9$16SygFXa4gmzsNdHnR/Gq/
        monitoring:$apr1$x.0UL7ik$7/A/p5vIAqPcHsem2/UM.0

/etc/nginx/htpasswd-dev:
  file.managed:
    - user: root
    - group: root
    - contents: |
        crowdrise:$apr1$bGpmtRQ2$Z1x21c8f.QTCSMSD.vvBb1
        monitoring:$apr1$x.0UL7ik$7/A/p5vIAqPcHsem2/UM.0

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


# Avoid a smurf attack
net.ipv4.icmp_echo_ignore_broadcasts:
  sysctl.present:
    - value: 1
 
# Turn on protection for bad icmp error messages
net.ipv4.icmp_ignore_bogus_error_responses:
  sysctl.present:
    - value: 1
 
# Turn on syncookies for SYN flood attack protection
net.ipv4.tcp_syncookies:
  sysctl.present:
    - value: 1
 
# Turn on and log spoofed, source routed, and redirect packets
#net.ipv4.conf.all.log_martians:
#net.ipv4.conf.default.log_martians:
 
# No source routed packets here
net.ipv4.conf.all.accept_source_route:
  sysctl.present:
    - value: 0
net.ipv4.conf.default.accept_source_route:
  sysctl.present:
    - value: 0
 
# Turn on reverse path filtering
net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - value: 1

net.ipv4.conf.default.rp_filter:
  sysctl.present:
    - value: 1
 
# Make sure no one can alter the routing tables
net.ipv4.conf.all.accept_redirects:
  sysctl.present:
    - value: 0
net.ipv4.conf.default.accept_redirects:
  sysctl.present:
    - value: 0
net.ipv4.conf.all.secure_redirects:
  sysctl.present:
    - value: 0
net.ipv4.conf.default.secure_redirects:
  sysctl.present:
    - value: 0
 
# Don't act as a router
net.ipv4.ip_forward:
  sysctl.present:
    - value: 0
net.ipv4.conf.all.send_redirects:
  sysctl.present:
    - value: 0
net.ipv4.conf.default.send_redirects:
  sysctl.present:
    - value: 0
 
# Turn on execshild
kernel.exec-shield:
  sysctl.present:
    - value: 1
kernel.randomize_va_space:
  sysctl.present:
    - value: 1
 
# Tuen IPv6
net.ipv6.conf.default.router_solicitations:
  sysctl.present:
    - value: 0
net.ipv6.conf.default.accept_ra_rtr_pref:
  sysctl.present:
    - value: 0
net.ipv6.conf.default.accept_ra_pinfo:
  sysctl.present:
    - value: 0
net.ipv6.conf.default.accept_ra_defrtr:
  sysctl.present:
    - value: 0
net.ipv6.conf.default.autoconf:
  sysctl.present:
    - value: 0
net.ipv6.conf.default.dad_transmits:
  sysctl.present:
    - value: 0
net.ipv6.conf.default.max_addresses:
  sysctl.present:
    - value: 1
 
# Optimization for port usefor LBs
# Increase system file descriptor limit
fs.file-max:
  sysctl.present:
    - value: 65535
 
# Allow for more PIDs (to reduce rollover problems)
# !!! may break some programs 32768
#kernel.pid_max:
 
# Increase system IP port limits
net.ipv4.ip_local_port_range:
  sysctl.present:
    - value: 3000 65000
