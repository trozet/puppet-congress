# == Class: congress
#
# Full description of class congress here.
#
# === Parameters
#
# [*ensure_package*]
#   (optional) The state of congress packages
#   Defaults to 'present'
#
# [*bind_host*]
#   (optional) The IP/interface to bind to
#   Defaults to $::os_service_default
#
# [*bind_port*]
#   (optional) The port to use
#   Defaults to $::os_service_default
#
# [*default_transport_url*]
#    (optional) A URL representing the messaging driver to use and its full
#    configuration. Transport URLs take the form:
#      transport://user:pass@host1:port[,hostN:portN]/virtual_host
#    Defaults to $::os_service_default
#
# [*rpc_backend*]
#   (optional) The rpc backend implementation to use, can be:
#     amqp (for AMQP 1.0 protocol)
#     rabbit (for rabbitmq)
#     zmq (for zeromq)
#   Defaults to 'rabbit'
#
# [*rabbit_host*]
#   (optional) Location of rabbitmq installation.
#   Defaults to $::os_service_default
#
# [*rabbit_hosts*]
#   (optional) List of clustered rabbit servers.
#   Defaults to $::os_service_default
#
# [*rabbit_port*]
#   (optional) Port for rabbitmq instance.
#   Defaults to $::os_service_default
#
# [*rabbit_password*]
#   (optional) Password used to connect to rabbitmq.
#   Defaults to $::os_service_default
#
# [*rabbit_userid*]
#   (optional) User used to connect to rabbitmq.
#   Defaults to $::os_service_default
#
# [*rabbit_virtual_host*]
#   (optional) The RabbitMQ virtual host.
#   Defaults to $::os_service_default
#
# [*rabbit_use_ssl*]
#   (optional) Connect over SSL for RabbitMQ
#   Defaults to $::os_service_default
#
# [*rabbit_ha_queues*]
#   (optional) Use HA queues in RabbitMQ.
#   Defaults to $::os_service_default
#
# [*rabbit_heartbeat_timeout_threshold*]
#   (optional) Number of seconds after which the RabbitMQ broker is considered
#   down if the heartbeat keepalive fails.  Any value >0 enables heartbeats.
#   Heartbeating helps to ensure the TCP connection to RabbitMQ isn't silently
#   closed, resulting in missed or lost messages from the queue.
#   (Requires kombu >= 3.0.7 and amqp >= 1.4.0)
#   Defaults to $::os_service_default
#
# [*rabbit_heartbeat_rate*]
#   (optional) How often during the rabbit_heartbeat_timeout_threshold period to
#   check the heartbeat on RabbitMQ connection.  (i.e. rabbit_heartbeat_rate=2
#   when rabbit_heartbeat_timeout_threshold=60, the heartbeat will be checked
#   every 30 seconds.
#   Defaults to $::os_service_default
#
# [*kombu_ssl_ca_certs*]
#   (optional) SSL certification authority file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_certfile*]
#   (optional) SSL cert file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_keyfile*]
#   (optional) SSL key file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_version*]
#   (optional) SSL version to use (valid only if SSL enabled).
#   Valid values are TLSv1, SSLv23 and SSLv3. SSLv2 may be
#   available on some distributions.
#   Defaults to $::os_service_default
#
# [*kombu_reconnect_delay*]
#   (optional) How long to wait before reconnecting in response to an AMQP
#   consumer cancel notification.
#   Defaults to '$::os_service_default
#
# [*kombu_compression*]
#   (optional) Possible values are: gzip, bz2. If not set compression will not
#   be used. This option may notbe available in future versions. EXPERIMENTAL.
#   (string value)
#   Defaults to $::os_service_default
#
# [*amqp_durable_queues*]
#   (optional) Define queues as "durable" to rabbitmq.
#   Defaults to $::os_service_default
#
# [*amqp_server_request_prefix*]
#   (Optional) Address prefix used when sending to a specific server
#   Defaults to $::os_service_default.
#
# [*amqp_broadcast_prefix*]
#   (Optional) address prefix used when broadcasting to all servers
#   Defaults to $::os_service_default.
#
# [*amqp_group_request_prefix*]
#   (Optional) address prefix when sending to any server in group
#   Defaults to $::os_service_default.
#
# [*amqp_container_name*]
#   (Optional) Name for the AMQP container
#   Defaults to $::os_service_default.
#
# [*amqp_idle_timeout*]
#   (Optional) Timeout for inactive connections
#   Defaults to $::os_service_default.
#
# [*amqp_trace*]
#   (Optional) Debug: dump AMQP frames to stdout
#   Defaults to $::os_service_default.
#
# [*amqp_ssl_ca_file*]
#   (Optional) CA certificate PEM file to verify server certificate
#   Defaults to $::os_service_default.
#
# [*amqp_ssl_cert_file*]
#   (Optional) Identifying certificate PEM file to present to clients
#   Defaults to $::os_service_default.
#
# [*amqp_ssl_key_file*]
#   (Optional) Private key PEM file used to sign cert_file certificate
#   Defaults to $::os_service_default.
#
# [*amqp_ssl_key_password*]
#   (Optional) Password for decrypting ssl_key_file (if encrypted)
#   Defaults to $::os_service_default.
#
# [*amqp_allow_insecure_clients*]
#   (Optional) Accept clients using either SSL or plain TCP
#   Defaults to $::os_service_default.
#
# [*amqp_sasl_mechanisms*]
#   (Optional) Space separated list of acceptable SASL mechanisms
#   Defaults to $::os_service_default.
#
# [*amqp_sasl_config_dir*]
#   (Optional) Path to directory that contains the SASL configuration
#   Defaults to $::os_service_default.
#
# [*amqp_sasl_config_name*]
#   (Optional) Name of configuration file (without .conf suffix)
#   Defaults to $::os_service_default.
#
# [*amqp_username*]
#   (Optional) User name for message broker authentication
#   Defaults to $::os_service_default.
#
# [*amqp_password*]
#   (Optional) Password for message broker authentication
#   Defaults to $::os_service_default.
#
# [*log_dir*]
#   (optional) Directory where logs should be stored.
#   If set to boolean false or the $::os_service_default, it will not log to
#   any directory.
#   Defaults to undef.
#
# [*debug*]
#   (optional) Set log output to debug output.
#   Defaults to undef
#
# [*use_syslog*]
#   (optional) Use syslog for logging
#   Defaults to undef
#
# [*use_stderr*]
#   (optional) Use stderr for logging
#   Defaults to undef
#
# [*log_facility*]
#   (optional) Syslog facility to receive log lines.
#   Defaults to undef
#
# [*notification_transport_url*]
#   (optional) A URL representing the messaging driver to use for notifications
#   and its full configuration. Transport URLs take the form:
#     transport://user:pass@host1:port[,hostN:portN]/virtual_host
#   Defaults to $::os_service_default
#
# [*notification_driver*]
#   (optional) Driver or drivers to handle sending notifications.
#   Value can be a string or a list.
#   Defaults to $::os_service_default
#
# [*notification_topics*]
#   (optional) AMQP topic used for OpenStack notifications
#   Defaults to $::os_service_default
#
# [*database_connection*]
#   (optional) Connection url for the congress database.
#   Defaults to undef.
#
# [*slave_connection*]
#   (optional) Connection url to connect to congress slave database (read-only).
#   Defaults to undef.
#
# [*database_max_retries*]
#   (optional) Maximum database connection retries during startup.
#   Defaults to undef.
#
# [*database_idle_timeout*]
#   (optional) Timeout before idle database connections are reaped.
#   Defaults to undef.
#
# [*database_retry_interval*]
#   (optional) Interval between retries of opening a database connection.
#   Defaults to undef.
#
# [*database_min_pool_size*]
#   (optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to undef.
#
# [*database_max_pool_size*]
#   (optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to undef.
#
# [*database_max_overflow*]
#   (optional) If set, use this value for max_overflow with sqlalchemy.
#   Defaults to: undef.
#
# [*purge_config*]
#   (optional) Whether to set only the specified config options
#   in the congress config.
#   Defaults to false.
#
# DEPRECATED PARAMETERS
#
# [*verbose*]
#   (optional) Deprecated. Set log output to verbose output.
#   Defaults to undef
#
class congress (
  $ensure_package                     = 'present',
  $bind_host                          = $::os_service_default,
  $bind_port                          = $::os_service_default,
  $default_transport_url              = $::os_service_default,
  $rpc_backend                        = 'rabbit',
  $rabbit_host                        = $::os_service_default,
  $rabbit_hosts                       = $::os_service_default,
  $rabbit_password                    = $::os_service_default,
  $rabbit_port                        = $::os_service_default,
  $rabbit_userid                      = $::os_service_default,
  $rabbit_virtual_host                = $::os_service_default,
  $rabbit_use_ssl                     = $::os_service_default,
  $rabbit_heartbeat_timeout_threshold = $::os_service_default,
  $rabbit_heartbeat_rate              = $::os_service_default,
  $rabbit_ha_queues                   = $::os_service_default,
  $kombu_ssl_ca_certs                 = $::os_service_default,
  $kombu_ssl_certfile                 = $::os_service_default,
  $kombu_ssl_keyfile                  = $::os_service_default,
  $kombu_ssl_version                  = $::os_service_default,
  $kombu_reconnect_delay              = $::os_service_default,
  $kombu_compression                  = $::os_service_default,
  $amqp_durable_queues                = $::os_service_default,
  $amqp_server_request_prefix         = $::os_service_default,
  $amqp_broadcast_prefix              = $::os_service_default,
  $amqp_group_request_prefix          = $::os_service_default,
  $amqp_container_name                = $::os_service_default,
  $amqp_idle_timeout                  = $::os_service_default,
  $amqp_trace                         = $::os_service_default,
  $amqp_ssl_ca_file                   = $::os_service_default,
  $amqp_ssl_cert_file                 = $::os_service_default,
  $amqp_ssl_key_file                  = $::os_service_default,
  $amqp_ssl_key_password              = $::os_service_default,
  $amqp_allow_insecure_clients        = $::os_service_default,
  $amqp_sasl_mechanisms               = $::os_service_default,
  $amqp_sasl_config_dir               = $::os_service_default,
  $amqp_sasl_config_name              = $::os_service_default,
  $amqp_username                      = $::os_service_default,
  $amqp_password                      = $::os_service_default,
  $debug                              = undef,
  $use_syslog                         = undef,
  $use_stderr                         = undef,
  $log_facility                       = undef,
  $log_dir                            = undef,
  $notification_transport_url         = $::os_service_default,
  $notification_driver                = $::os_service_default,
  $notification_topics                = $::os_service_default,
  $database_connection                = undef,
  $slave_connection                   = undef,
  $database_idle_timeout              = undef,
  $database_min_pool_size             = undef,
  $database_max_pool_size             = undef,
  $database_max_retries               = undef,
  $database_retry_interval            = undef,
  $database_max_overflow              = undef,
  $purge_config                       = false,
  # DEPRECATED PARAMETERS
  $verbose                            = undef,
) inherits congress::params {

  include ::congress::db
  include ::congress::logging

  package { 'congress':
    ensure => $ensure_package,
    name   => $::congress::params::common_package_name,
    tag    => ['openstack', 'congress-package'],
  }

  resources { 'congress_config':
    purge  => $purge_config,
  }

  congress_config {
    'DEFAULT/bind_host':               value => $bind_host;
    'DEFAULT/bind_port':               value => $bind_port;
  }

  if $verbose {
    warning('verbose is deprecated, has no effect and will be removed after Newton cycle.')
  }

  if $rpc_backend == 'rabbit' {
    oslo::messaging::rabbit { 'congress_config':
      rabbit_userid               => $rabbit_userid,
      rabbit_password             => $rabbit_password,
      rabbit_virtual_host         => $rabbit_virtual_host,
      rabbit_host                 => $rabbit_host,
      rabbit_port                 => $rabbit_port,
      rabbit_hosts                => $rabbit_hosts,
      rabbit_ha_queues            => $rabbit_ha_queues,
      heartbeat_timeout_threshold => $rabbit_heartbeat_timeout_threshold,
      heartbeat_rate              => $rabbit_heartbeat_rate,
      rabbit_use_ssl              => $rabbit_use_ssl,
      kombu_reconnect_delay       => $kombu_reconnect_delay,
      kombu_ssl_version           => $kombu_ssl_version,
      kombu_ssl_keyfile           => $kombu_ssl_keyfile,
      kombu_ssl_certfile          => $kombu_ssl_certfile,
      kombu_ssl_ca_certs          => $kombu_ssl_ca_certs,
      kombu_compression           => $kombu_compression,
      amqp_durable_queues         => $amqp_durable_queues,
    }
  }
  elsif $rpc_backend == 'amqp' {
    oslo::messaging::amqp { 'congress_config':
      server_request_prefix  => $amqp_server_request_prefix,
      broadcast_prefix       => $amqp_broadcast_prefix,
      group_request_prefix   => $amqp_group_request_prefix,
      container_name         => $amqp_container_name,
      idle_timeout           => $amqp_idle_timeout,
      trace                  => $amqp_trace,
      ssl_ca_file            => $amqp_ssl_ca_file,
      ssl_cert_file          => $amqp_ssl_cert_file,
      ssl_key_file           => $amqp_ssl_key_file,
      ssl_key_password       => $amqp_ssl_key_password,
      allow_insecure_clients => $amqp_allow_insecure_clients,
      sasl_mechanisms        => $amqp_sasl_mechanisms,
      sasl_config_dir        => $amqp_sasl_config_dir,
      sasl_config_name       => $amqp_sasl_config_name,
      username               => $amqp_username,
      password               => $amqp_password,
    }
  }

  oslo::messaging::default { 'congress_config':
    transport_url => $default_transport_url,
  }

  oslo::messaging::notifications { 'congress_config':
    transport_url => $notification_transport_url,
    driver        => $notification_driver,
    topics        => $notification_topics,
  }

}
