# Class: name
#
#
class role::webserver {
  #contain profile::apache::base_install
  #contain profile::apache::vh_install
  #contain profile::apache::wwwdata_deploy
  contain profile::tomcat::base_install
}
