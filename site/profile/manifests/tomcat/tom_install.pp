# profile::tomcat::tom_install
# Installs Tomcat with configuration

class profile::tomcat::tom_install (
  $java_home             = lookup('java::java_home'),
  $catalina_home         = lookup('tomcat::parameters.catalina_home'),
  $catalina_base         = lookup('tomcat::parameters.catalina_base'),
  $tomcatuser            = lookup('tomcat::parameters.user'),
  $tomcatgroup           = lookup('tomcat::parameters.group'),
  $tomcatservicename     = lookup('tomcat::parameters.servicename'),
  $tomcat_app_root       = lookup('app_root'),
)
{

  package { 'tomcat':
    ensure => 'letest'
  }
  # Install tomcat service
  ~> service { 'tomcat':
      ensure => 'stopped'
    }

  # Tomcat Default directory creation 
  $tomcat_default_dir = [
    "${tomcat_app_root}/",
    "${catalina_home}/",
    "${catalina_home}/webapps",
    "${catalina_home}/work",
    "${catalina_home}/temp",
    "${catalina_home}/logs",
    "${catalina_home}/conf",
  ]

  # Root catalina_home directory creation 
  file { $tomcat_default_dir :
      ensure  => directory,
      force   => true,
      group   => $tomcatuser,
      owner   => $tomcatgroup,
      mode    => '0755',
      recurse => true,
    }

  # Root catalina_home directory creation 
  file { '/app/tomcat/lib' :
    type   => link,
    target => '/usr/share/java/tomcat',
  }
  # Root catalina_home directory creation 
  file { '/app/tomcat/bin':
    type   => link,
    target => '/usr/share/tomcat/bin',
  }
}

