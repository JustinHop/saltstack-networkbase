#!/bin/bash
# Need csync2 to create the key
# Need rng-tools to create entropy
# csync2 uses /dev/random. VMs do not typically generate enough entropy
apt-get install -y csync2 rng-tools

# start the key creation
csync2 -k csync2.key &

# Start creating entropy
rngd --background --rng-device=/dev/urandom &

# One second usually enough
sleep 1
pkill -f rngd
wait
