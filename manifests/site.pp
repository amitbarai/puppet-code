node 'node1' {
  package { 'httpd':
    ensure => 'absent',
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
