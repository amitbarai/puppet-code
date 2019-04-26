# Class: apache
# Initial installation
# 
class profile::apache::base_install {
  package { 'httpd':
    ensure => 'present'
  }
  service { 'httpd':
    ensure  => 'running',
    require => Package['httpd'],
  }
}
