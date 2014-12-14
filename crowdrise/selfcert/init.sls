#
#   crowdrise/selfcert/init.sls
#   Creates Self Signed Certs
#


/etc/pki/tls/cert:
  file.directory:
    - makedirs: true
    - mode: 755
    - user: root
    - group: root

/etc/pki/tls/private:
  file.directory:
    - makedirs: true
    - mode: 700
    - user: root
    - group: root

gen-privatekey:
  cmd.run:
    - name: >
      openssl genrsa
      -out /etc/pki/tls/private/{{ grains['fqdn'] }}.-2048.key
      2048
    - creates: /etc/pki/tls/private/{{ grains['fqdn'] }}.-2048.key

gen-certreq:
  cmd.run:
    - name: >
      openssl req
      -new
      -key /etc/pki/tls/private/{{ grains['fqdn'] }}.-2048.key
      -out /etc/pki/tls/cert/{{ grains['fqdn'] }}-self.2048.csr
      -subj "/C=US/ST=California/L=Los Angeles/O=CrowdRise/CN={{ grains['fqdn'] }}"
    - creates: /etc/pki/tls/cert/{{ grains['fqdn'] }}-self.2048.csr
    - requires:
      - file: /etc/pki/tls/private/{{ grains['fqdn'] }}.-2048.key

gen-selfsign:
  cmd.run:
    - name: >
      openssl x509
      -req
      -days 3650
      -in /etc/pki/tls/cert/{{ grains['fqdn'] }}-self.2048.csr
      -signkey /etc/pki/tls/private/{{ grains['fqdn'] }}.-2048.key
      -out /etc/pki/tls/cert/{{ grains['fqdn'] }}-self.2048.crt
    - creates: /etc/pki/tls/cert/{{ grains['fqdn'] }}-self.2048.crt
    - requires:
      - file: /etc/pki/tls/private/{{ grains['fqdn'] }}.-2048.key
      - file: /etc/pki/tls/cert/{{ grains['fqdn'] }}-self.2048.csr
