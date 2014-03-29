# Install Apache
class apache {
case $operatingsystem {
  centos: {$apache = "httpd"}
  redhat: {$apache = "httpd"}
  debian: {$apache = "apache2"}
}


package {'Apache Web Server':
  name   => $apache,
  ensure => 'installed',
  before => File['httpd.conf'],
}
  
file {'httpd.conf':
  ensure  => present,
  owner   => 'apache',
  group   => 'apache',
  content => template("${module_name}/httpd.erb"),
}

service {'httpd':
  ensure     => 'running',
  enable     => 'true',
  hasstatus  => 'true',
  hasrestart => 'true',
  }
}

