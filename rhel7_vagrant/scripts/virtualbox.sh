yum install -y bzip2
mkdir /mnt/cdrom2
mount -o loop ~/VBoxGuestAdditions.iso /mnt/cdrom2
sh /mnt/cdrom2/VBoxLinuxAdditions.run
rm -rf ~/VBoxGuestAdditions.iso
