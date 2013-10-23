group {"puppet":
	ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { "/etc/motd": 
	content => "Vagrant managed by puppet... it works!",
}

exec { "apt-update": command => "/usr/bin/apt-get update", }
Exec["apt-update"] -> Package <| |>

$default_password = "123456"
$default_email		= "admin@example.com"
$default_token		= "e09884cfa5d10e938b02"

