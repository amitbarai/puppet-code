# Class: profile::apache::vh_install
#
#
class profile::apache::vh_install (
  $apache_vh_root   = lookup('apache_vh_root'),
  $apache_conf_root = lookup('apache_conf_root'),
  $vh_example_com   = lookup('vh_example_com'),
)
  {
    file { 'apache_vh_root':
    ensure => directory,
    path   => "${apache_conf_root}/${apache_vh_root}",
    owner  => root,
    group  => root,
    mode   => '0644',
    }
    file_line { 'vh_dir_add':
      ensure            => present,
      path              => "${apache_conf_root}/conf/httpd.conf",
      after             => '^IncludeOptional\ conf.d/*.conf',
      line              => "IncludeOptional ${apache_vh_root}/*.conf",
      multiple          => false,
      match_for_absence => true,
  }
    file { 'vh_example_com.conf':
      ensure  => file,
      path    => "/etc/httpd/vh.d/${vh_example_com}.conf",
      content => template('profile/apache/vh_example_com.conf.erb'),
      # Loads /etc/puppetlabs/code/environments/production/site/profile/templates/apache/vh_example_com.conf.erb
    }
}
