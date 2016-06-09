# Installs & configure the congress api service
#
# == Parameters
#
# [*enabled*]
#   (optional) Should the service be enabled.
#   Defaults to true
#
# [*manage_service*]
#   (optional) Whether the service should be managed by Puppet.
#   Defaults to true.
#
# [*keystone_user*]
#   (optional) The name of the auth user
#   Defaults to congress
#
# [*keystone_tenant*]
#   (optional) Tenant to authenticate with.
#   Defaults to 'services'.
#
# [*keystone_password*]
#   Password to authenticate with.
#   Mandatory.
#
# [*keystone_auth_uri*]
#   (optional) Public Identity API endpoint.
#   Defaults to 'false'.
#
# [*keystone_identity_uri*]
#   (optional) Complete admin Identity API endpoint.
#   Defaults to: false
#
# [*host*]
#   (optional) The congress api bind address.
#   Defaults to 0.0.0.0
#
# [*port*]
#   (optional) The congress api port.
#   Defaults to 8042
#
# [*package_ensure*]
#   (optional) ensure state for package.
#   Defaults to 'present'
#
# [*service_name*]
#   (optional) Name of the service that will be providing the
#   server functionality of congress-api.
#   If the value is 'httpd', this means congress-api will be a web
#   service, and you must use another class to configure that
#   web service. For example, use class { 'congress::wsgi::apache'...}
#   to make congress-api be a web app using apache mod_wsgi.
#   Defaults to '$::congress::params::api_service_name'
#
# [*sync_db*]
#   (optional) Run congress-upgrade db sync on api nodes after installing the package.
#   Defaults to false

class congress::api (
  $manage_service        = true,
  $enabled               = true,
  $package_ensure        = 'present',
  $keystone_user         = 'congress',
  $keystone_tenant       = 'services',
  $keystone_password     = false,
  $keystone_auth_uri     = false,
  $keystone_identity_uri = false,
  $host                  = '0.0.0.0',
  $port                  = '8042',
  $service_name          = $::congress::params::api_service_name,
  $sync_db               = false,
) inherits congress::params {

  include ::congress::params
  include ::congress::policy

  validate_string($keystone_password)

  Congress_config<||> ~> Service[$service_name]
  Class['congress::policy'] ~> Service[$service_name]

  Package['congress-api'] -> Service[$service_name]
  Package['congress-api'] -> Service['congress-api']
  Package['congress-api'] -> Class['congress::policy']
  package { 'congress-api':
    ensure => $package_ensure,
    name   => $::congress::params::api_package_name,
    tag    => ['openstack', 'congress-package'],
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }
  }

  if $sync_db {
    include ::congress::db::sync
  }

  if $service_name == $::congress::params::api_service_name {
    service { 'congress-api':
      ensure     => $service_ensure,
      name       => $::congress::params::api_service_name,
      enable     => $enabled,
      hasstatus  => true,
      hasrestart => true,
      require    => Class['congress::db'],
      tag        => 'congress-service',
    }
  } elsif $service_name == 'httpd' {
    include ::apache::params
    service { 'congress-api':
      ensure => 'stopped',
      name   => $::congress::params::api_service_name,
      enable => false,
      tag    => 'congress-service',
    }
    Class['congress::db'] -> Service[$service_name]

    # we need to make sure congress-api/eventlet is stopped before trying to start apache
    Service['congress-api'] -> Service[$service_name]
  } else {
    fail('Invalid service_name. Either congress/openstack-congress-api for running as a standalone service, or httpd for being run by a httpd server')
  }

  congress_config {
    'keystone_authtoken/auth_uri'          : value => $keystone_auth_uri;
    'keystone_authtoken/admin_tenant_name' : value => $keystone_tenant;
    'keystone_authtoken/admin_user'        : value => $keystone_user;
    'keystone_authtoken/admin_password'    : value => $keystone_password, secret => true;
    'api/host'                             : value => $host;
    'api/port'                             : value => $port;
  }

  if $keystone_identity_uri {
    congress_config {
      'keystone_authtoken/identity_uri': value => $keystone_identity_uri;
    }
  } else {
    congress_config {
      'keystone_authtoken/identity_uri': ensure => absent;
    }
  }

}
