# Class: profile::apache::vh_install
#
#
class profile::apache::vh_install (
  $ssl              = lookup('profile::hiera_test::ssl'),
  $backups_enabled  = lookup('profile::hiera_test::backups_enabled'),
  $env_globalcustom = lookup('tomcat::bin::setenv'),)
  {
}
file { '/etc/httpd/vh.d':
  ensure => directory,
  owner  => root,
  group  => root,
  mode   => '0644',
}
