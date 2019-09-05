# profile::tomcat::tom_install
# Installs Tomcat with configuration

class profile::tomcat::tom_install (
  $java_home             = lookup('java::java_home'),
  $catalina_home         = lookup('tomcat::parameters.catalina_home'),
  $catalina_base         = lookup('tomcat::parameters.catalina_base'),
  $tomcatuser            = lookup('tomcat::parameters.user'),
  $tomcatgroup           = lookup('tomcat::parameters.group'),
  $tomcatservicename     = lookup('tomcat::parameters.servicename'),
  $catalina_base_lib     = lookup('tomcat::parameters.catalina_base')/lib,
  $catalina_base_bin     = lookup('tomcat::parameters.catalina_base')/bin,
)
{
  # Tomcat Default directory creation 
  $tomcat_default_dir = [
    "${catalina_home}/webapps",
    "${catalina_home}/work",
    "${catalina_home}/temp",
    "${catalina_home}/logs",
    "${catalina_home}/conf",
  ]

  # Install tomcat service
  ->service { 'tomcat':
      ensure => 'present'
    }

  # Root catalina_home directory creation 
  ->file { $tomcat_default_dir:
      ensure => directory,
      force  => true,
      group  => $tomcatuser,
      user   => $tomcatuser,
      mode   => '0755',
    }

  # Root catalina_home directory creation 
  ~>file { $catalina_base_lib:
    ensure => present,
    type   => links,
    target => '/usr/share/tomcat/lib',
  }
    # Root catalina_home directory creation 
  ~>file { $catalina_base_bin:
    ensure => present,
    type   => links,
    target => '/usr/share/tomcat/bin',
  }
}

