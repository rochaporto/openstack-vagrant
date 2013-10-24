# keystone.pp

#
# Keystone setup and configuration 
#
class { "keystone::db::mysql":
	password      => "${default_password}",
	allowed_hosts => ["localhost", "%"],
}

class { "keystone":
	verbose        => true,
	catalog_type   => "sql",
	admin_token    => "${default_token}",
	sql_connection => "mysql://keystone:${default_password}@localhost/keystone",
}

keystone_tenant { "services": ensure => present, enabled => "True", }

keystone_role { "admin": ensure => present, }
	
