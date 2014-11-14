

chrootlogin:
  pkg.installed:
    - names: 
      - makejail
      - libpam-chroot
      #  file.managed:
        #    - name: /etc/makejail/create-remote.py
    
