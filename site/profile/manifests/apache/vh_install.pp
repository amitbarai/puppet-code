# Class: profile::apache::vh_install
#
#
class profile::apache::vh_install (
  $apache_vh_root   = lookup('apache_vh_root'),
  )
  {
  file { $apache_vh_root:
  ensure => directory,
  owner  => root,
  group  => root,
  mode   => '0644',
  }
}
