
# master configuration
Package["puppetmaster"] -> Service["puppetmaster"]
package { "puppetmaster": ensure => present, }

service { "puppetmaster": ensure => running, }

file { "/etc/puppet/modules":
	ensure => "link",
	target => "/vagrant/puppet/modules",
	force  => true,
}

file { "/etc/puppet/manifests":
	ensure => "link",
	target => "/vagrant/puppet/manifests",
	force  => true,
}

# puppetdb configuration
class { 'puppetdb':
  ssl_listen_address => '0.0.0.0',
}
include puppetdb::master::config
