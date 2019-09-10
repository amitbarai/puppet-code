# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tomy::package
class tomy::package {

  # Install tomcat service
    package { 'tomcat':
    ensure => 'latest'
  }

  # stop tomcat service from running on default port
  ~> service { 'tomcat':
      ensure => 'stopped'
  }
}
