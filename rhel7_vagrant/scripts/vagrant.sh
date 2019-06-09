sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
useradd -p $(echo vagrant|openssl passwd -1 -stdin) vagrant
mkdir -pm 700 /home/vagrant/.ssh
curl -L https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
cat <<EOF > /etc/sudoers.d/vagrant
%vagrant ALL=(ALL) NOPASSWD: ALL
EOF
