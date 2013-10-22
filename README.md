## What

This is a simple way to quickly get a working OpenStack setup for testing or playing.

It provides the basic components split in the following nodes:

   * puppet: the required modules and manifests for the setup
   * controller: keystone, glance, nova
   * compute1: nova-compute

## How

```shell
apt-get install vagrant
git clone git@github.com:rochaporto/openstack-vagrant
cd openstack-vagrant
```

If you want to customize things:
```shell
vim Vagrantfile
```

Otherwise business as usual:
```
vagrant up puppet
vagrant up controller
vagrant up compute1
```

And to go into the machines:
```
vagrant ssh puppet
```

## TODO

- [ ] get the nodes configured using puppet

