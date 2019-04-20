# /etc/puppetlabs/code/environments/production/modules/profile/manifests/hiera_test.pp
class profile::hiera_test (
  $ssl             = lookup('profile::hiera_test::ssl'),
  $backups_enabled = lookup('profile::hiera_test::backups_enabled')
) {
  file { '/tmp/hiera_test.txt':
    ensure  => file,
    content => @("END"),
            value1  ${ssl}
            value2  ${backups_enabled}
               |END
    owner   => root,
    mode    => '0644',
  }
}
