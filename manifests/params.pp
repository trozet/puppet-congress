# Parameters for puppet-congress
#
class congress::params {

  $client_package_name = 'python-ceilometerclient'

  case $::osfamily {
    'RedHat': {
      $common_package_name     = 'openstack-congress-common'
      $api_package_name        = 'openstack-congress-api'
      $api_service_name        = 'openstack-congress-api'

      $congress_wsgi_script_path   = '/var/www/cgi-bin/congress'
      $congress_wsgi_script_source = '/usr/lib/python2.7/site-packages/congress/api/app.wsgi'
    }
    'Debian': {
      $common_package_name     = 'congress-common'
      $api_package_name        = 'congress-api'
      $api_service_name        = 'congress-api'
      $congress_wsgi_script_path   = '/usr/lib/cgi-bin/congress'
      $congress_wsgi_script_source = '/usr/share/congress-common/app.wsgi'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily
}
