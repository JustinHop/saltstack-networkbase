cryptoboots:
  pkg:
    - installed
    - names:
      - initramfs-tools
      - dropbear
      - busybox
      - cryptsetup
      - cryptmount

check-crypto-update:
  cmd.run:
    - name: find /etc/initramfs-tools -ls | md5sum - | perl -pe 's/\s+/=/'
    - stateful: True

update-initramfs:
  cmd.wait:
    - name: /usr/sbin/update-initramfs -u
    - watch:
      - cmd: check-crypto-update

/etc/initramfs-tools/conf.d/network_config:
  file.managed:
    - source: salt://sys/phy/cryptoboot/files/network_config
    - template: jinja
    - user: root
    - group: root
    - mode: 400

/etc/initramfs-tools/initramfs.conf:
  file.managed:
    - source: salt://sys/phy/cryptoboot/files/initramfs.conf
    - user: root
    - group: root
    - mode: 644

/etc/initramfs-tools/update-initramfs.conf:
  file.managed:
    - source: salt://sys/phy/cryptoboot/files/update-initramfs.conf
    - user: root
    - group: root
    - mode: 644

/etc/initramfs-tools/hooks/mount_cryptroot:
  file.managed:
    - source: salt://sys/phy/cryptoboot/files/mount_cryptroot
    - user: root
    - group: root
    - mode: 750

/etc/default/cryptdisks:
  file.managed:
    - source: salt://sys/phy/cryptoboot/files/cryptdisks
    - user: root
    - group: root
    - mode: 600

/etc/default/dropbear:
  file.managed:
    - source: salt://sys/phy/cryptoboot/files/dropbear
    - user: root
    - group: root
    - mode: 600

/etc/initramfs-tools/root/.ssh:
  file.directory:
    - user: root
    - group: root
    - mode: 750
    - makedirs: True

prepare-dropbear-keys:
  cmd.run:
    - name: cp -v /etc/ssh/authorized_keys/justin /etc/initramfs-tools/root/.ssh/authorized_keys

/etc/initramfs-tools/root/.ssh/authorized_keys:
  file.managed:
    - user: root
    - group: root
    - mode: 600
