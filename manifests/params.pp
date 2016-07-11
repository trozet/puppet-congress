#
# This class contains the platform differences for congress
#
class congress::params {
  $client_package_name = 'python-congressclient'
  $datasource_list     = 'congress.datasources.neutronv2_driver.NeutronV2Driver,congress.datasources.glancev2_driver.GlanceV2Driver,congress.datasources.nova_driver.NovaDriver,congress.datasources.keystone_driver.KeystoneDriver,congress.datasources.ceilometer_driver.CeilometerDriver,congress.datasources.cinder_driver.CinderDriver'

  case $::osfamily {
    'Debian': {
      $package_name                 = 'congress'
      $service_name                 = 'congress'
      $python_memcache_package_name = 'python-memcache'
      $sqlite_package_name          = 'python-pysqlite2'
      $paste_config                 = undef
      case $::operatingsystem {
        'Debian': {
          $service_provider            = undef
        }
        default: {
          $service_provider            = 'upstart'
        }
      }
    }
    'RedHat': {
      $package_name                 = 'openstack-congress'
      $service_name                 = 'openstack-congress'
      $python_memcache_package_name = 'python-memcached'
      $sqlite_package_name          = undef
      $service_provider             = undef
    }
  }
}
