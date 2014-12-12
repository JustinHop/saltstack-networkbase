#Clean the jail

cleanJailFirst=1

#preserve=["/home"]

chroot="/var/chroot/ssh"

users=["root","remote"]

groups=["root","remote"]

packages=["coreutils", "openssh-client", "screen"]
