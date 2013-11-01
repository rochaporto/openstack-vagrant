# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	# Common configuration to all machines
	config.vm.box = "precise64"
	config.vm.provider "virtualbox" do |vb|
		vb.customize ["modifyvm", :id, "--memory", "384"]
	end
	config.vm.provider "lxc" do |lxc|
		lxc.customize "cgroup.memory.limit_in_bytes", "384M"
	end

	# Puppet master machine (directly applies puppet to launch the master)
	config.vm.define "puppet", primary: true do |puppet|
		puppet.vm.hostname = "puppet.example.com"
		puppet.vm.network "private_network", ip: "10.0.3.100"
		puppet.vm.provider :lxc do |lxc|
			lxc.customize "network.ipv4", "10.0.3.100/24"
		end
		puppet.vm.provision "puppet" do |puppet|
			puppet.manifests_path = "puppet/manifests"
			puppet.module_path = "../openstack-puppet-catalyst/modules"
			puppet.manifest_file = "master.pp"
			puppet.options = ["--pluginsync"]
		end
	end

	# Controller (runs most openstack services)
	config.vm.define "controller" do |controller|
		controller.vm.hostname = "controller.example.com"
		controller.vm.network "private_network", ip: "10.0.3.101"
		controller.vm.provider :lxc do |lxc|
			lxc.customize "network.ipv4", "10.0.3.101/24"
		end
		controller.vm.provision "puppet_server" do |puppet|
			puppet.puppet_server = "10.0.3.100"
			puppet.options = ["--pluginsync"]
		end
	end

end
