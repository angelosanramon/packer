mkdir /mnt/cdrom1
mount -o loop /dev/sr0 /mnt/cdrom1
cp /mnt/cdrom1/media.repo /etc/yum.repos.d/rhel7dvd.repo
chmod 644 /etc/yum.repos.d/rhel7dvd.repo
echo 'enabled=1' >> /etc/yum.repos.d/rhel7dvd.repo
echo 'baseurl=file:///mnt/cdrom1' >> /etc/yum.repos.d/rhel7dvd.repo
echo 'gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release' >> /etc/yum.repos.d/rhel7dvd.repo
yum -y install gcc make gcc-c++ kernel-devel-`uname -r` perl