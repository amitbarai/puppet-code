# Class: profile::apache::vh_install
#
#
class profile::apache::vh_install (
  $apache_vh_root   = lookup('apache_vh_root'),
  $apache_conf_root = lookup('apache_conf_root')
  )
  {
  file { 'apache_vh_root':
  ensure => directory,
  path   => $apache_conf_root/$apache_vh_root,
  owner  => root,
  group  => root,
  mode   => '0644',
  }
  -> file_line { 'add_vh_dir_add':
      ensure            => present,
      path              => $apache_conf_root/conf/httpd.conf,
      after             => '^IncludeOptional\ conf.d/*.conf',
      match             => '^IncludeOptional\ vh.d/*.conf',
      match_for_absence => true,
    }
}

