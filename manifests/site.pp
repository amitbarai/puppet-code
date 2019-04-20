node 'node1' {
  #include role::tomcat_install
  include role::hiera_testing
}
