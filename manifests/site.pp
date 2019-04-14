node 'node1' {
  package { 'httpd':
    ensure => 'present',
  }
  service {'httpd':
    ensure => stopped,
    enable => false,
  }
  ->service { 'firewalld' :
    ensure => 'stopped',
    enable => false,
  }
}
