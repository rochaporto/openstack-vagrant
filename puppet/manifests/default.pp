group {"puppet":
	ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { "/etc/motd": 
	content => "Vagrant managed by puppet... it works!",
}
