## What

This is a simple way to quickly get a working OpenStack setup for testing or playing.

By default the following nodes are available:

   * master: not much here, but it might be useful for additional services
   * controller: openstack keystone, glance, nova
   * compute1: openstack nova-compute

## How

```shell
apt-get install git vagrant
git clone git@github.com:rochaporto/openstack-vagrant
cd openstack-vagrant
git submodule init
git submodule update
```

Optionally, if you want to customize things:
```shell
vim Vagrantfile
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
puppet apply ...
```

The puppet stuff is kept under /tmp/vagrant-puppet in each VM, and these are the real files.

