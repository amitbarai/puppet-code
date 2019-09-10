
# Class: tomy
# ===========================
#
# A description of what this class does
#
# @example
#   include tomy
class tomy (
  $java_home             = lookup('java::java_home'),
  $catalina_home         = lookup('tomcat::parameters.catalina_home'),
  $catalina_base         = lookup('tomcat::parameters.catalina_base'),
  $tomcatuser            = lookup('tomcat::parameters.user'),
  $tomcatgroup           = lookup('tomcat::parameters.group'),
  $tomcatservicename     = lookup('tomcat::parameters.servicename'),
  $tomcat_app_root       = lookup('app_root'),
  $tomcat_port_http      = lookup('tomcat::parameters.port.http'),
  $tomcat_port_ajp       = lookup('tomcat::parameters.port.ajp'),
  $tomcat_port_shutdown  = lookup('tomcat::parameters.port.shutdown'),
)
{
  case $::osfamily {
    'RedHat': {
      # tomcat isntallation sequence
      contain ::tomy::package
      contain ::tomy::install
      contain ::tomy::config

      Class['::tomy::package']
      ->Class['::tomy::install']
      ->Class['::tomy::config']
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}