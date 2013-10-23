import "default.pp"

class { "mysql::server": }

#
# Keystone setup and configuration 
#
class { "keystone::db::mysql":
	password			=> "${default_password}",
	allowed_hosts	=> ["localhost", "%"],
}

class { "keystone":
	verbose					=> true,
	catalog_type		=> "sql",
	admin_token			=> "${default_token}",
	sql_connection	=> "mysql://keystone:${default_password}@localhost/keystone",
}
	
#
# Glance setup and configuration
#

class { "glance::db::mysql":
	password			=> "${default_password}",
	allowed_hosts	=> ["localhost", "%"],
}

class { "glance::api":
	verbose						=> true,
	keystone_password	=> "${default_password}",
	sql_connection		=> "mysql://glance:${default_password}@localhost/glance",
}

class { "glance::registry":
	verbose						=> true,
	keystone_tenant		=> "service",
	keystone_user			=> "glance",
	keystone_password	=> "${default_password}",
	sql_connection		=> "mysql://glance:${default_password}@localhost/glance",
}

class { "glance::keystone::auth":
	password					=> "${default_password}",
	email							=> "${default_email}",
	public_address		=> $ipaddress,
	admin_address			=> $ipaddress,
	internal_address	=> $ipaddress,
	region						=> "${default_region}",
}

