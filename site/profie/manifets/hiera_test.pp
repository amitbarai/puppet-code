# /etc/puppetlabs/code/environments/production/modules/profile/manifests/hiera_test.pp
class profile::hiera_test (
  Boolean             $ssl,
  Boolean             $backups_enabled,
  Optional[String[1]] $site_alias = undef,
) {
  file { '/tmp/hiera_test.txt':
    ensure  => file,
    content => @("END"),
              ${ssl}
              ${backups_enabled}
              ${site_alias}
               |END
    owner   => root,
    mode    => '0644',
  }
}
