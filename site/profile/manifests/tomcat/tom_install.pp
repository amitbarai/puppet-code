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
  $tomcat_port_http      = lookup('tomcat::parameters.port_http'),
  $tomcat_port_ajp       = lookup('tomcat::parameters.port_ajp'),
  $tomcat_port_shutdown  = lookup('tomcat::parameters.port_shutdown'),
)
{
  class { '::tomy':
    java_home            => $java_home,
    catalina_home        => $catalina_home,
    catalina_base        => $catalina_base,
    tomcatuser           => $tomcatuser,
    tomcatgroup          => $tomcatgroup,
    tomcatservicename    => $tomcatservicename,
    tomcat_app_root      => $tomcat_app_root,
    tomcat_port_http     => $tomcat_port_http,
    tomcat_port_ajp      => $tomcat_port_ajp,
    tomcat_port_shutdown => $tomcat_port_shutdown,
  }
  contain ::tomy
}
