#!/bin/bash




if ! [ -d "/etc/Profile/bin" ]; then
  exit 0
fi

cd /usr/local/bin
for BINFILE in /etc/Profile/bin/* ; do
  if [ ! -h $BINFILE ]; then
    ln -s $BINFILE || true 2>&1 > /dev/null
  fi
done
