## What

This is a simple way to quickly get a working OpenStack setup for testing or playing.

By default the following nodes are available:

   * master: not much here, but it might be useful for additional services
   * controller: mysql, openstack keystone, glance
   * compute1: openstack nova-compute

Each one having its own puppet configuration under puppet/manifests.

## How

```shell
apt-get install git vagrant
git clone git@github.com:rochaporto/openstack-vagrant
cd openstack-vagrant
git submodule init
git submodule update
```

Brings the latest github stackforge modules by default, customize as needed. Exception is mysql - openstack stuff still depends on puppetlabs mysql 0.x.

If you want to customize the VM configuration:
```shell
vim Vagrantfile
```

If you want to use the LXC provider instead:
```
vagrant plugin install lxc
vagrant box add precise64 http://bit.ly/vagrant-lxc-precise64-2013-10-23
export VAGRANT_DEFAULT_PROVIDER=lxc
```

Otherwise business as usual:
```
vagrant up master 
vagrant up controller
vagrant up compute1
```

And to go into the machines:
```
vagrant ssh controller 
```

## Puppeting

When you're playing with puppet manifests, you can either:
```
vagrant provision controller
```
or else keep a shell and do puppet apply locally:
```
vagrant ssh controller
puppet apply --pluginsync --modulepath '/etc/puppet/modules:/tmp/vagrant-puppet/modules-0' controller.pp
```

The puppet stuff is kept under /tmp/vagrant-puppet in each VM, and these are the real files.

