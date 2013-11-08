# puppetdb.pp

class profiles::puppetdb {

  class {"::puppetdb":
    ssl_listen_address => hiera("puppetdb::ssl_listen_address", "0.0.0.0"),
  }

  # workaround for ssl cert creation (the module does not seem to do it)
  exec {"/usr/sbin/puppetdb-ssl-setup":
    command => "/usr/sbin/puppetdb-ssl-setup",
    unless  => "/usr/bin/file /etc/puppetdb/ssl/private.pem",
  }

  Exec["/usr/sbin/puppetdb-ssl-setup"] -> Service["puppetdb"]

}
