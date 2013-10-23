group {"puppet": ensure => "present", }

File { owner => 0, group => 0, mode => 0644, }

file { "/etc/motd": content => "Vagrant managed by puppet... it works!", }

$default_password = "123456"
$default_email    = "admin@example.com"
$default_token    = "e09884cfa5d10e938b02"
$default_region   = "1.example.com"

# TODO: Should be able to simply require_packages = "ubuntu-cloud-keyring",
# but something's broken in the box image and need to apt-get update first
Apt::Source["cloudarchive-havana"] -> Exec["apt-update"] -> Package<| |>
exec { "apt-update": 
  command => "/usr/bin/apt-get clean; /usr/bin/apt-get update; /usr/bin/apt-get install ubuntu-cloud-keyring; /usr/bin/apt-get clean; /usr/bin/apt-get update", }
apt::source { "cloudarchive-havana":
	location          => "http://ubuntu-cloud.archive.canonical.com/ubuntu",
	repos             => "main",
	release           => "precise-updates/havana",
	#required_packages => "ubuntu-cloud-keyring",
}

