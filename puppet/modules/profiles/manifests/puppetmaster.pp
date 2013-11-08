# puppetmaster.pp

class profiles::puppetmaster {

  Package["puppetmaster"] -> Service["puppetmaster"]

  package {"puppetmaster":
    ensure => present,
  }

  service {"puppetmaster":
    ensure => running,
  }

  #class {"puppetdb::master::config":
  #  puppetdb_server => hiera("puppetdb::host", $::hostname),
  #}

}
