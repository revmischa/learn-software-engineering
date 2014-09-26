#!/bin/bash
. /tmp/common.sh
set -x
# if [ ! -e /home/vagrant/.vbox_version ] ; then
#     exit 0
# fi

# VirtualBox Additions
sudo yum -y install gcc make automake autoconf libtool gcc-c++ kernel-headers-`uname -r` kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget nfs-utils bind-utils

sudo yum -y --enablerepo=epel install dkms

sudo yum -y upgrade

# Installing vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
VBOX_ISO=/home/vagrant/VBoxGuestAdditions_${VBOX_VERSION}.iso
cd /tmp

if [ ! -f $VBOX_ISO ] ; then
    wget -q http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso \
        -O $VBOX_ISO
fi
mount -o loop $VBOX_ISO /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm $VBOX_ISO

if [ -f /etc/redhat-release ] ; then
    $yum remove kernel-devel-$(uname -r)
    $yum clean all
elif [ -f /etc/debian_version ] ; then
    $apt remove linux-headers-$(uname -r)
    $apt autoremove
fi
