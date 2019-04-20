# /etc/puppetlabs/code/environments/production/modules/profile/manifests/hiera_test.pp
class profile::hiera_test::hiera_test (
  $ssl              = lookup('profile::hiera_test::ssl'),
  $backups_enabled  = lookup('profile::hiera_test::backups_enabled'),
  $env_globalcustom = lookup('tomcat::bin::setenv'),
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
  file { '/tmp/test2':
    ensure  => 'present',
    content => @("END"),
    value2    ${env_globalcustom}
              |END
  }
  file { '/tmp/dansfile':
  ensure => file,
}
-> file_line { 'dans_line':
  line => 'dan is awesome',
  path => '/tmp/dansfile',
}
}
