## What

This is a simple way to quickly get a working OpenStack setup for testing or playing.

It provides the basic components split in the following nodes:

   * master: not much here, but it might be useful for additional services 
   * controller: openstack keystone, glance, nova
   * compute1: openstack nova-compute

## How

```shell
apt-get install vagrant
git clone git@github.com:rochaporto/openstack-vagrant
cd openstack-vagrant
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

