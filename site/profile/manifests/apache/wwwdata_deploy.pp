# Class: name
#
#
class profile::apache::wwwdata_deploy (
  $apache_apps_root = lookup('apache_apps_root'),
) {
  file { '$apache_apps_root':
    ensure => directory,
    mode   => '0755',
  }
}
