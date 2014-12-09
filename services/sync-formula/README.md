# A salt formula for syncing web files across multiple web servers.

This formula utilizes lsyncd, csync2, and xinetd.

These states are very, very version specific.
Only tested so far on Ubuntu 12.04, Lsyncd 2.0.4. The lua for the lsyncd
configuration will need to change if using other versions of lsyncd. This
formula may be altered in the future to provide different lsyncd
configurations for the different versions of lsyncd.

#### Salt-Mine
This formula requires the salt-mine in order to function. Each host that is to
be synced will need to contribute the ip address of the preferred interface as
well as the hostname to the salt mine.

Example salt-mine pillar(should be available for every host that should sync)
```yaml
mine_functions:
  network.ip_addrs: [eth0]
  grains.get: ['host']
```

#### Pillar
The following example pillar will describe how to customize this formula.
```yaml
sync:
  # Need to indicate how to determine what other minions to sync with.
  # This will translate to salt['mine.get'](target, some_func, expr_form)
  # inside of settings.jinja.

  # Default: roles:web
  target: roles:web

  # Default: grains
  expr_type: grains

  # Name of the sync group
  # Default: default
  group: default

  # List of directories/files to include
  # Default: []
  includes:
    - /var/www/dir1
    - /var/www/dir2

  # List of directories/files to exclude
  # Default: []
  excludes:
    - /var/www/*log

  # How to resolve conflicts (older, newer, or none)
  # Default: none
  conflict: none

# The 'private' interface determines what xinetd binds to.
interfaces:
  # Default: eth0
  private: eth0
```

#### How to use
Create the csync2 key before running any of the states.

```shell
cd sync/files/csync2
sudo bash generate_key.sh
```

Note: the above method will install csync2 and rng-tools. rng-tools is used
to create entropy.

If applying from a top file:
```shell
salt <sync-targets> state.highstate
```
Or if applying explicitly:
```shell
salt <sync-targets> state.sls sync-formula
```

Also, minions in the above command will finish at different times and some minions may fail to keep the lsyncd service going (only because the others aren't available yet). You just need to make sure to apply the sync state a second time or run the following:
```shell
salt <sync-targets> service.start lsyncd
```

#### Helpful links
* [csync2](http://oss.linbit.com/csync2/)
* [lsyncd](https://code.google.com/p/lsyncd/)
