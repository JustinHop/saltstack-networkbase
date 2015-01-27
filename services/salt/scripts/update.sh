#!/usr/bin/ssh-agent /bin/bash

ssh-add /srv/salt/.ssh/id_rsa

cd /srv/salt

for PART in filebase pillar reactor ; do 
   cd /srv/salt/saltstack-${PART}.git
   pwd
   git fetch --all
done

for FORMULA in salt deployment sphinxsearch ; do
   cd /srv/salt/${FORMULA}-formula.git
   pwd
   git fetch --all
done

salt-run fileserver.update
salt-call saltutil.sync_all
