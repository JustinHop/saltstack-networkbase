#
#   Physical Systems Base
#   sys/phy/init.sls
#

include:
  - sys/phy/cryptoboot
  - sys/phy/udev

physical-systems:
  pkg.installed:
    - names:
      - e2fsprogs
      - apt-file
      - aufs-tools
      - bridge-utils
      - cryptmount
      - cryptsetup
      - debootstrap
      - hdparm
      - iotop
      - htop
      - lshw
      - nilfs-tools
