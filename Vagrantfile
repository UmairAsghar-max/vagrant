# -*- mode: ruby -*-
# # vi: set ft=ruby :

Vagrant.configure(2) do |config|

    config.vm.define "kube-lab" do |s|
      s.ssh.forward_agent = true
      s.vm.box = "bento/ubuntu-22.04"
      s.vm.hostname = "kube-lab"
      s.vm.provision "shell", path: "setup-scripts/setup.sh"
      s.vm.network "private_network", ip: "172.42.42.1", netmask: "255.255.255.0",
        auto_config: true,
        virtualbox__intnet: "k8s-net"
      s.vm.network "forwarded_port", guest: 7681, host:3001
      s.vm.provider "virtualbox" do |v|
        v.name = "kube-lab"
        v.memory = 4096
        v.gui = false
      end
    end
  
end