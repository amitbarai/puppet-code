# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tomy::config
class tomy::config (
  $java_home             = $::java::java_home,
  $catalina_home         = $::tomcat::parameters.catalina_home,
  $catalina_base         = $::tomcat::parameters.catalina_base,
  $tomcatuser            = $::tomcat::parameters.user,
  $tomcatgroup           = $::tomcat::parameters.group,
  $tomcatservicename     = $::tomcat::parameters.servicename,
  $tomcat_app_root       = $::app_root,
  $tomcat_port_http      = $::tomcat::parameters.port.http,
  $tomcat_port_ajp       = $::tomcat::parameters.port.ajp,
  $tomcat_port_shutdown  = $::tomcat::parameters.port.shutdown,
)
{
  # Verifies that class is called from an init.psp and not directly
  assert_private()

#- name: Copy configuration files to conf directory
  exec {'copy catlina_base conf':
    command => "cp -r /etc/tomcat/* ${catalina_base}/conf/.",
    user    => $tomcatuser,
    group   => $tomcatgroup,
    path    => '/bin:/usr/local/bin:/usr/bin',
    onlyif  => "/usr/bin/test ! -d ${catalina_base}/conf",
  }

# Creation of catalina_base
  file { "${catalina_base}/":
    ensure  => 'directory',
    owner   => $tomcatuser,
    group   => $tomcatgroup,
    mode    => '0755',
    recurse => true,
  }

## Config file for set_env.sh.erb
#  file { "${catalina_base}/bin/set_env.sh":
#    ensure  => 'present',
#    owner   => $tomcatuser,
#    group   => $tomcatgroup,
#    mode    => '0755',
#    content => template('tomy/set_env.sh.erb'),
#  }

# Configure environment Tomcat server
file { "${catalina_base}/conf/tomcat.conf":
  ensure  => 'present',
  owner   => $tomcatuser,
  group   => $tomcatgroup,
  mode    => '0755',
  content => template('tomy/tomcat.conf.erb')
}

#  Changing ports in server.xml file
  exec {'copy catlina_base conf':
    command => "sed -i 's/8005/${$tomcat_port_shutdown}/g; s/8080/${$tomcat_port_http}/g; s/8010/${$tomcat_port_ajp}/g' ${catalina_base}/conf/server.xml", #lint:ignore:140chars
    path    => '/bin:/usr/local/bin:/usr/bin',
    onlyif  => "/usr/bin/test ! -d ${catalina_base}/conf",
  }

# create start up script
file { "/etc/systemd/system/${tomcatservicename}.service":
  ensure  => 'present',
  content => template('tomy/tomcat.service.erb')
}

#  Start Tomcat 
service { "${tomcatservicename}.service":
  ensure => 'running'
}

}