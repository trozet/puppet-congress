#
# Class to execute "congress-dbsync"
#
# [*user*]
#   (optional) User to run dbsync command.
#   Defaults to 'congress'
#
class congress::db::sync (
  $user = 'congress',
){
  exec { 'congress-db-sync':
    command     => 'congress-dbsync --config-file /etc/congress/congress.conf',
    path        => '/usr/bin',
    refreshonly => true,
    user        => $user,
    logoutput   => on_failure,
  }

  Package<| tag == 'congress-package' |> ~> Exec['congress-db-sync']
  Exec['congress-db-sync'] ~> Service<| tag == 'congress-db-sync-service' |>
  Congress_config<||> ~> Exec['congress-db-sync']
  Congress_config<| title == 'database/connection' |> ~> Exec['congress-db-sync']
}
