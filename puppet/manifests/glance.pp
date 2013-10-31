# glance.pp

#
# Glance setup and configuration
#
class { "glance::db::mysql":
	user          => "glance",
	password      => "${default_password}",
	dbname        => "glance",
	host          => "localhost",
	allowed_hosts => ["localhost", "%"],
}

class { "glance::api":
	verbose           => true,
	auth_host         => "localhost",
	keystone_tenant   => "services",
	keystone_user     => "glance",
	keystone_password => "${default_password}",
	sql_connection    => "mysql://glance:${default_password}@localhost/glance",
}

class { "glance::registry":
	verbose           => false,
	auth_host         => "localhost",
	keystone_tenant   => "services",
	keystone_user     => "glance",
	keystone_password => "${default_password}",
	sql_connection    => "mysql://glance:${default_password}@localhost/glance",
}

Keystone_tenant["services"] -> Keystone_role["admin"] -> Class["glance::keystone::auth"]
class { "glance::keystone::auth":
	auth_name        => "glance",
	password         => "${default_password}",
	email            => "${default_email}",
	public_address   => $ipaddress,
	admin_address    => $ipaddress,
	internal_address => $ipaddress,
	region           => "${default_region}",
}

class { "glance::backend::rbd":
	rbd_store_user   => "images",
	rbd_store_pool   => "images",
}

Apt::Key["ceph"] -> Apt::Source["ceph"] -> File["/etc/ceph"] -> File["/etc/ceph/keyring"] -> File["/etc/ceph/ceph.conf"] -> Class["glance::backend::rbd"]
file { "/etc/ceph": ensure => directory, }
file { "/etc/ceph/ceph.conf":
	ensure   => present,
	owner    => "glance",
	group    => "glance",
	mode     => 0600,
	content  => 
inline_template("[global]
auth cluster required = cephx
auth service required = cephx
auth client required = cephx

[mon.0]
  host = <%= ceph_mon_host %> 
  mon addr = <%= ceph_mon_addr %>
"),
}
file { "/etc/ceph/keyring":
	ensure   => present,
	owner    => "glance",
	group    => "glance",
	mode     => 0600,
	content  =>
inline_template("
[client.images]
key = <%= ceph_keyring %>
"),
}
# ceph auth get-or-create client.images mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=images'

apt::key { "ceph":
	key        => "17ED316D",
	key_source => "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc",
}

#Apt::Source["ceph"] -> Apt::Source["cloudarchive-havana"]
apt::source { "ceph":
	location => "http://ceph.com/debian-bobtail/",
	release  => "wheezy main",
	require  => Apt::Key["ceph"],
}
