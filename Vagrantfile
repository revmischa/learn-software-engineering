# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|  
  config.vm.define "dev", primary: true do |dev|
    # stored in vagrantcloud
    dev.vm.box = "revmischa/dev"
    dev.vm.box_version = ">= 1.0"
    # testing local builds
    #dev.vm.box = "tools/packer/centos.box"

    #dev.vm.network "forwarded_port", guest: 3000, host: 3000
    dev.ssh.username = "vagrant"

    # use host DNS resolver
    dev.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
    #dev.vm.network :public_network  # bridged (breaks stuff idk why)

    # provision
    $dev_provision = <<DEVPROV
DEVPROV
    config.vm.provision "shell", inline: $dev_provision
  end
end
