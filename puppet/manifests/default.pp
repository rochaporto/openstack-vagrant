group {"puppet":
	ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { "/etc/motd": 
	content => "Vagrant managed by puppet... it works!",
}

$default_password = "123456"
$default_email		= "admin@example.com"
$default_token		= "e09884cfa5d10e938b02"
$default_region		= "1.example.com"

class { "apt": }

apt::source { "cloudarchive-havana":
	location					=> "http://ubuntu-cloud.archive.canonical.com/ubuntu",
	release						=> "precise-updates/havana",
	repos							=> "main",
	required_packages	=> "ubuntu-cloud-keyring",
}

