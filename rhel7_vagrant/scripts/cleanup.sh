yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y clean all
rm -rf ~/VBoxGuestAdditions.iso
rm -rf /tmp/*
rm -f /etc/yum.repos.d/rhel7dvd.repo

umount /mnt/cdrom1
umount /mnt/cdrom2
rm -rf /mnt/cdrom*

# zero out empty disk space
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
