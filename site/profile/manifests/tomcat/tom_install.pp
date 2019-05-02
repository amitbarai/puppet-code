# profile::tomcat::tom_install
# Installs Tomcat with configuration

class profile::tomcat::tom_install (
  $java_home             = lookup('java::java_home'),
  $catalina_home         = lookup('tomcat::catalina_home'),
  #$source_url            = lookup('tomcat::install::source_url'),
  $tomcatuser            = lookup('tomcat::user'),
  $tomcatusergroup       = lookup('tomcat::group'),
  $tomcatservicename     = lookup('tomcat::servicename'),
  #$ld_library_path       = lookup('tomcat::ld_library_path'),
)
{
  # Tomcat Default Apps For Removal
  $tomcat_default_apps = [
    "${catalina_home}/webapps/docs",
    "${catalina_home}/webapps/examples",
    "${catalina_home}/webapps/host-manager",
    "${catalina_home}/webapps/manager",
  ]

  class { '::tomcat': }

# Install Tomcat
  ->::tomcat::install { $catalina_home:
    source_url => $source_url,
  }

# Removing default Tomcat applications
  ->file { $tomcat_default_apps:
    ensure => absent,
    force  => true,
  }
#  ->file { "/etc/systemd/system/${tomcatservicename}.service":
#    content => epp('tomcat/tomcat-systemd.epp', {
#      'catalinaHome'    => $catalina_home,
#      'java_home'       => $java_home,
#      'tomcatUser'      => $tomcatuser,
#      'tomcatGroup'     => $tomcatusergroup,
#      'ld_library_path' => $ld_library_path,
#      }
#    ),
#    owner   => 'root',
#    group   => 'root',
#    mode    => '0644',
#    }

  ~>exec { 'tomcat_systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }
  ~>service { $tomcatservicename:
    ensure => running,
    enable => true,
  }
}
