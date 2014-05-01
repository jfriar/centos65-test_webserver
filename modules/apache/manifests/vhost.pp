# == Define: apache::vhost
#
# Installs an apache vhost configuration.
#
# === Parameters
#
# [*docroot*]
#   The DocumentRoot to use for the vhost.  Required.
#
# [*port*]
#   The port the apache vhost will listen on.  Required.
#
# [*site*]
#   The "name" of the vhost.  This will be used for directory
#   structure.  Defaults to "$title".
#
# [*template*]
#   The erb template to use for generating the vhost configuration.
#   Defaults to "apache/vhost-template.conf.erb".
#
# [*options*]
#   The apache "Options" to use with the vhost.
#   Defaults to "Indexes FollowSymLinks MultiViews".
#
# [*override*]
#   The apche "Override" to use with the vhost.
#   Defaults to "none".
#
# [*disable*]
#   If set to true, the apache vhost configuration will be removed.
#   Defaults to "false".
#
# === Actions
#
# - installs or removes a vhost configuration file
# - ensures that the vhost DocumentRoot exists
#
# === Requires
#
# - apache
# - apache::params
#
# === Examples
#
#   apache::vhost { "localhost_81":
#       docroot =>  '/var/www/localhost_81',
#       port    =>  '81',
#   }
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
define apache::vhost (
    $docroot,
    $port,
    $site           =   $title,
    $template       =   'apache/vhost-template.conf.erb',
    $options        =   'Indexes FollowSymLinks MultiViews',
    $override       =   'none',
    $disable        =   'false'
) {

    include ::apache::params
    include ::apache

    $vhost_file = "${apache::params::vhosts_conf_dir}/${site}.conf"
    $log_dir = "${apache::params::vhosts_log_dir}"

    if $disable == 'true' {
        $set_ensure = absent
        $set_backup = '.disable'
    } else {
        $set_ensure = present
        $set_backup = puppet
    }

    # make sure the docroot exists (apache DocumentRoot)
    file { $docroot:
        ensure  =>  directory,
        owner   =>  root,
        group   =>  root,
        mode    =>  0755,
        require =>  [Package["${apache::params::apache_pkg}"]],
    }

    # install the vhost file
    file { $vhost_file:
        ensure  =>  $set_ensure,
        backup  =>  $set_backup,
        content =>  template($template),
        owner   =>  root,
        group   =>  root,
        mode    =>  0644,
        require =>  [Package["${apache::params::apache_pkg}"],File["${apache::params::vhosts_conf_dir}"]],
        notify  =>  Service["${apache::params::apache_svc}"],
    }

}
