class mysql::server {
  package { "mysql-server":
   ensure => installed,
  } 
  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  } 
  file { "/etc/mysql/my.cnf":
    owner => "mysql",
    group => "mysql", 
    source => "/tmp/vagrant-puppet/manifests/files/mysql/my.cnf",
    notify => Service["mysql"], 
    require => Package["mysql-server"], 
  }
  exec { "set-mysql-password":
    unless => "/usr/bin/mysqladmin -uroot -p${mysql_password} status",
    command => "/usr/bin/mysqladmin -uroot password ${mysql_password}",
    require => Service["mysql"],
  }
  
}
