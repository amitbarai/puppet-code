# Class: role:tomcat_install
#
#
class role::tomcat_install {
  contain profile::basewithjava
  contain profile::tomcat

  Class['profile::basewithjava']
  ->Class['profile::tomcat']
}
