# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tomy::install
class tomy::install (
  $java_home             = $::java::java_home,
  $catalina_home         = lookup('tomcat::parameters.catalina_home'),
  $catalina_base         = lookup('tomcat::parameters.catalina_base'),
  $tomcatuser            = lookup('tomcat::parameters.user'),
  $tomcatgroup           = lookup('tomcat::parameters.group'),
  $tomcatservicename     = lookup('tomcat::parameters.servicename'),
  $tomcat_app_root       = lookup('app_root'),
  $tomcat_port_http      = lookup('tomcat::parameters.port_http'),
  $tomcat_port_ajp       = lookup('tomcat::parameters.port_ajp'),
  $tomcat_port_shutdown  = lookup('tomcat::parameters.port_shutdown'),
)
{
  # Verifies that class is called from an init.psp and not directly
  assert_private()

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
    target => '/usr/share/java/tomcat',
  }

  # Root catalina_home directory creation 
  file { '/app/tomcat/bin' :
    ensure => 'link',
    target => '/usr/share/tomcat/bin',
  }

}
