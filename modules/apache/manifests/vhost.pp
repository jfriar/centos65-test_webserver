# == Define: apache::vhost
#
# Full description of defined resource type apache::vhost here.
#
# === Parameters
#
# Document parameters here
#
# [*namevar*]
#   If there is a parameter that defaults to the value of the title string
#   when not explicitly set, you must always say so.  This parameter can be
#   referred to as a "namevar," since it's functionally equivalent to the
#   namevar of a core resource type.
#
# [*basedir*]
#   Description of this variable.  For example, "This parameter sets the
#   base directory for this resource type.  It should not contain a trailing
#   slash."
#
# === Actions
#
# - stuff
#
# === Requires
#
# - logrotate
# - repos (ccit repo)
#
# === Examples
#
# Provide some examples on how to use this type:
#
#   example_class::apache::vhost { 'namevar':
#     basedir => '/tmp/src',
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
    $serveraliases  =   '',
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

    # install the vhost file
    file { "$vhost_file":
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
