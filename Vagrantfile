# -*- mode: ruby -*-
# # vi: set ft=ruby :

Vagrant.configure(2) do |config|

    (1).each do |i|
      config.vm.define "master" do |s|
        s.ssh.forward_agent = true
        s.vm.box = "bento/ubuntu-22.04"
        s.vm.hostname = "master"
        s.vm.network "private_network", ip: "172.42.42.100", netmask: "255.255.255.0",
          auto_config: true,
          virtualbox__intnet: "k8s-net"
        s.vm.provider "virtualbox" do |v|
          v.name = "master"
          v.memory = 4096
          v.gui = false
        s.vm.provision "shell", path: "scripts/common.sh"
        s.vm.provision "shell", path: "scripts/master.sh"
        end
      end
    end

    (1..2).each do |i|
      config.vm.define "worker#{i}" do |s|
        s.ssh.forward_agent = true
        s.vm.box = "bento/ubuntu-22.04"
        s.vm.hostname = "worker#{i}"
        s.vm.network "private_network", ip: "172.42.42.#{i}", netmask: "255.255.255.0",
          auto_config: true,
          virtualbox__intnet: "k8s-net"
        s.vm.provider "virtualbox" do |v|
          v.name = "worker#{i}"
          v.memory = 2048
          v.gui = false
        s.vm.provision "shell", path: "scripts/common.sh"
        s.vm.provision "shell", path: "scripts/worker.sh"
        end
      end
    end
  
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
    end
  
  end