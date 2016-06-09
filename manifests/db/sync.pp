#
# Class to execute "congress-manage db_sync
#
class congress::db::sync {
  exec { 'congress-manage db_sync':
    path        => '/usr/bin',
    command     => 'congress-db-manage --config-file /etc/congress/congress.conf upgrade head',
    user        => 'congress',
    refreshonly => true,
    subscribe   => [Package['congress'], congress_config['database/connection']],
    require     => User['congress'],
  }

  Exec['congress-manage db_sync'] ~> Service<| title == 'congress' |>
}
