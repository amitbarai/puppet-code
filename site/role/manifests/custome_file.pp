# Class: role::custome_file
#
#
class role::custome_file {
  contain profile::hiera_test

  Class'profile::hiera_test'
}
