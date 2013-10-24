# -*- mode: ruby -*-
# vi: set ft=ruby :

# Cute domain here
DOMAIN="example.com"

# Just in case you want to customize this
SUBNET="192.168.0"

# You may want to use some different box image
BOX="precise64"
BOXURL="http://files.vagrantup.com/precise64.box"

Vagrant.configure("2") do |config|

	# Common configuration to all machines
	config.vm.box = "#{BOX}"
	config.vm.box_url = "#{BOXURL}"
	config.vm.provider "virtualbox" do |vb|
		vb.customize ["modifyvm", :id, "--memory", "384"]
	end

	# Our master machine
	config.vm.define "master" do |vmconfig|
		vmconfig.vm.network :private_network, ip: "#{SUBNET}.101"
		vmconfig.vm.hostname = "master.#{DOMAIN}"

		vmconfig.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "puppet/modules" do |puppet|
			puppet.manifests_path = "puppet/manifests"
			puppet.manifest_file = "master.pp"
		end
	end

	# Controller
	config.vm.define "controller" do |vmconfig|
		vmconfig.vm.network :private_network, ip: "#{SUBNET}.102"
		vmconfig.vm.hostname = "controller.#{DOMAIN}"

		vmconfig.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "puppet/modules" do |puppet|
			puppet.manifests_path = "puppet/manifests"
			puppet.manifest_file = "controller.pp"
		end
	end

	# Nova compute node
	config.vm.define "compute1" do |vmconfig|
		vmconfig.vm.network :private_network, ip: "#{SUBNET}.103"
		vmconfig.vm.hostname = "compute1.#{DOMAIN}"

		vmconfig.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "puppet/modules" do |puppet|
			puppet.manifests_path = "puppet/manifests"
			puppet.manifest_file = "compute1.pp"
		end
	end

	# Ceph mon node
	config.vm.define "ceph" do |vmconfig|
		vmconfig.vm.network :private_network, ip: "#{SUBNET}.104"
		vmconfig.vm.hostname = "ceph.#{DOMAIN}"

		vmconfig.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "puppet/modules" do |puppet|
			puppet.manifests_path = "puppet/manifests"
			puppet.manifest_file = "ceph.pp"
		end
	end
		
	# Ceph OSD node
	config.vm.define "ceph-osd1" do |vmconfig|
		vmconfig.vm.network :private_network, ip: "#{SUBNET}.105"
		vmconfig.vm.hostname = "ceph-osd1.#{DOMAIN}"

		vmconfig.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "puppet/modules" do |puppet|
			puppet.manifests_path = "puppet/manifests"
			puppet.manifest_file = "ceph-osd1.pp"
		end
	end
end
