# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|  
  config.vm.define "dev", primary: true do |dev|
    # stored in vagrantcloud
    #dev.vm.box = "revmischa/dev"
    #dev.vm.box_version = ">= 1.0"
    # testing local builds
    #dev.vm.box = "tools/packer/centos.box"

    dev.vm.box = "hfm4/centos7"

    #dev.vm.network "forwarded_port", guest: 3000, host: 3000
    dev.ssh.username = "vagrant"
    #dev.ssh.password = "vagrant"
    dev.ssh.forward_agent = true

    # use host DNS resolver
    dev.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
    #dev.vm.network :public_network  # bridged (breaks stuff idk why)

    dev.vm.synced_folder '.', '/home/vagrant'

    # provision
    $dev_provision = <<DEVPROV
yum install -y git python-virtualenv wget epel-release
wget http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm && sudo rpm -i pgdg-centos94-9.4-1.noarch.rpm && rm *.rpm
yum install -y postgis2_94 postgresql94-server
/usr/pgsql-9.4/bin/postgresql94-setup initdb
systemctl start postgresql-9.4.service
DEVPROV
    config.vm.provision "shell", inline: $dev_provision
  end
end
