# profile::base
# The class defines basic configuration for every node in the production/DR environment
#
# Version 20181114-1230
#
class profile::basewithjava
{
  # Include all base prerequisites
  contain profile::base_initial

  # Include monitoring for all nodes
  contain profile::java

  # Ordering
  Class['::profile::base_initial']
  ->Class['::profile::java']
}
