# The congress::auth class helps configure auth settings
#
# == Parameters
#  [*auth_url*]
#    the keystone public endpoint
#    Optional. Defaults to 'http://localhost:5000/v2.0'
#
#  [*auth_region*]
#    the keystone region of this node
#    Optional. Defaults to 'RegionOne'
#
#  [*auth_user*]
#    the keystone user for congress services
#    Optional. Defaults to 'congress'
#
#  [*auth_password*]
#    the keystone password for congress services
#    Required.
#
#  [*auth_tenant_name*]
#    the keystone tenant name for congress services
#    Optional. Defaults to 'services'
#
#  [*auth_tenant_id*]
#    the keystone tenant id for congress services.
#    Optional. Defaults to undef.
#
#  [*auth_cacert*]
#    Certificate chain for SSL validation. Optional; Defaults to 'undef'
#
#  [*auth_endpoint_type*]
#    Type of endpoint in Identity service catalog to use for
#    communication with OpenStack services.
#    Optional. Defaults to undef.
#
class congress::auth (
  $auth_password,
  $auth_url           = 'http://localhost:5000/v2.0',
  $auth_region        = 'RegionOne',
  $auth_user          = 'congress',
  $auth_tenant_name   = 'services',
  $auth_tenant_id     = undef,
  $auth_cacert        = undef,
  $auth_endpoint_type = undef,
) {

  if $auth_cacert {
    congress_config { 'service_credentials/os_cacert': value => $auth_cacert }
  } else {
    congress_config { 'service_credentials/os_cacert': ensure => absent }
  }

  congress_config {
    'service_credentials/os_auth_url'    : value => $auth_url;
    'service_credentials/os_region_name' : value => $auth_region;
    'service_credentials/os_username'    : value => $auth_user;
    'service_credentials/os_password'    : value => $auth_password, secret => true;
    'service_credentials/os_tenant_name' : value => $auth_tenant_name;
  }

  if $auth_tenant_id {
    congress_config {
      'service_credentials/os_tenant_id' : value => $auth_tenant_id;
    }
  }

  if $auth_endpoint_type {
    congress_config {
      'service_credentials/os_endpoint_type' : value => $auth_endpoint_type;
    }
  }

}
