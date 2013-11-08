# config.pp

class roles::config {

  include profiles::base
  include profiles::puppetmaster
  include profiles::puppetdb

  Class["profiles::puppetmaster"] -> Class["profiles::puppetdb"]

  #class {"puppetdb::master::config":
  #  puppetdb_server => hiera("puppetdb::host", $::hostname),
  #}

}
