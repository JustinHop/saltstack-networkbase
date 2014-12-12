# Makejail configuration file for sshd
# 
# Created by Javier Fernandez-sanguino Peña  <jfs@computer.org>
# Thu, 29 Aug 2002 23:44:51 +0200
#
chroot="/var/chroot/sshd"
forceCopy=["/etc/ssh/ssh_host*","/etc/ssh/sshd*","/etc/ssh/moduli",
	"/etc/pam.conf","/etc/security/*","/etc/pam.d/ssh","/etc/pam.d/other",
	"/etc/hosts","/etc/nsswitch.conf",
	"/var/run/sshd","/lib/security/*",
	"/etc/shells", "/etc/nologin","/etc/environment","/etc/motd",
	"/etc/shadow","/etc/hosts*",
	"/bin/*sh", "/lib/libnss*",
	"/dev/pt*","/dev/ttyp[0-9]*"]

# Remove this if you want to make configuration changes *outside* of the
# chroot environment
# preserve=["/etc/","/home/","/dev/"]
# otherwise just do this:
#preserve=["/dev/","/home"]
preserve=["/dev/"]

# Besides the sshd user (needed after 3.4p1) any user which is going to
# be granted access to the ssh daemon should be added to 'users' and
# 'groups'.
userFiles=["/etc/passwd","/etc/shadow"]
groupFiles=["/etc/group","/etc/gshadow"]
users=["sshd","remote"]
groups=["sshd","remote"]

testCommandsInsideJail=["start-stop-daemon --start --quiet --pidfile /var/run/sshd.pid --exec /usr/sbin/sshd"]
testCommandsOutsideJail=["ssh localhost"]

processNames=["sshd"]

# Changes to do to jail sshd:
# 1.- start makejail with this configuration file
# it might not be able to start the daemon since the daemon tries to
# access /dev/log (handled by syslogd)
#
# 2.- In init.d's startup script (/etc/init.d/sshd):
# replace "start-stop-daemon ..." with "chroot /var/chroot/sshd start-stop-daemon ..."
#
# 3.- configure syslog to also listen to the socket /var/chroot/sshd/dev/log, 
# restart sysklogd. 
# (for Debian) This can be done by changing the SYSLOGD option in
# /etc/init.d/syslogd to
# SYSLOGD="-p /dev/log -p /var/chroot/sshd/dev/log"
#
# 4.- Create the user directories under /home and copy their files there
#
# 5.- Users will not be able to a single thing in the restricted environment
#     besides running their shell. You will have to add some utilities
#     to the chrooted environement. Try adding this to the configuration
# packages=["fileutils"]
#     You can add any other Debian packages you want users to have access
#     to.
# 
# WARNING: this configuration file has only been slightly tested. not yet thoroughly tested yet.
