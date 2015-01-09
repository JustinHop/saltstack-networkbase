#
#   services/rackspace/backup.sls
#   cloud backups mofo
#

cloudbackup-updater:
  pkg.installed:
    - sources:
      - cloudbackup-updater: http://agentrepo.drivesrvr.com/debian/cloudbackup-updater-latest.deb
  cmd.run:
    - name: cloudbackup-updater -v
    - creates: /usr/local/bin/driveclient
    - requires:
      - pkg: cloudbackup-updater

/usr/local/bin/driveclient:
  cmd.run:
    - name: rm /etc/driveclient/bootstrap.json; /usr/local/bin/driveclient --configure --username {{ salt['pillar.get']('rackspace:username', 'user') }} --apikey {{ salt['pillar.get']('rackspace:apikey', 'api') }}
    - unless: |
        grep '"IsRegistered" : true' /etc/driveclient/bootstrap.json
    - requires:
      - pkg: cloudbackup-updater
      - file: /usr/local/bin/driveclient
      - cmd: cloudbackup-updater
      - pkg: driveclient

driveclient:
  service.running:
    - reload: true
    - requires:
      - cmd: cloudbackup-updater
      - pkg: cloudbackup-updater
      - onfail:
        - cmd: /usr/local/bin/driveclient
