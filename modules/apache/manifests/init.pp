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
  before => File['/etc/httpd/conf/httpd.conf'],
}
  
file {'/etc/httpd/conf/httpd.conf':
  ensure => present,
  owner  => 'apache',
  group  => 'apache',
  source => '/root/examples/httpd.conf'
}

service {'httpd':
  ensure     => 'running',
  enable     => 'true',
  hasstatus  => 'true',
  hasrestart => 'true',
  subscribe  => File['/etc/httpd/conf/httpd.conf']
  }
}

