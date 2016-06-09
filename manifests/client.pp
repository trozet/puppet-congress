#
# Installs the congress python library.
#
# == parameters
#  [*ensure*]
#    ensure state for pachage.
#
class congress::client (
  $ensure = 'present'
) {

  include ::congress::params

  # there is no congressclient yet
  package { 'python-ceilometerclient':
    ensure => $ensure,
    name   => $::congress::params::client_package_name,
    tag    => 'openstack',
  }

}

