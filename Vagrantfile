# -*- mode: ruby -*-
# # vi: set ft=ruby :

require "yaml"
settings = YAML.load_file "settings.yaml"

VM_NAME = settings["vm_name"]
VM_PORT_CONSOLE = settings["vm_port_console"]
VM_PORT_SSH = settings["vm_port_ssh"]


Vagrant.configure(2) do |config|

    config.vm.define "#{VM_NAME}" do |s|
      s.ssh.forward_agent = true
      s.vm.box = "bento/ubuntu-22.04"
      s.vm.hostname = "#{VM_NAME}"
      s.vm.provision "shell", path: "setup-scripts/setup.sh"
      s.vm.network "private_network", ip: "172.42.42.1", netmask: "255.255.255.0", auto_config: true
      s.vm.network "forwarded_port", guest: 7681, host:VM_PORT_CONSOLE
      s.vm.network "forwarded_port", guest: 22, host:VM_PORT_SSH
      s.vm.provider "virtualbox" do |v|
        v.name = "#{VM_NAME}"
        v.memory = 4096
        v.gui = false
      end
    end
  
end