# Class: name
#
#
class profile::apache::wwwdata_deploy (
  $apache_apps_root = lookup('apache_apps_root'),
) {
  file { 'app_path':
    ensure => directory,
    path   => $apache_apps_root,
    mode   => '0755',
  }
}
