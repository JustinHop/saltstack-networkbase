#!/bin/bash




if ! [ -d "/etc/Profile/bin" ]; then
  exit 0
fi

cd /usr/local/bin
for BINFILE in /etc/Profile/bin/* ; do
  ln -s $BINFILE || true 2>&1 > /dev/null
done
