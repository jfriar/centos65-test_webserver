# == Class: apache
#
# Full description of class apache here.
#
# === Parameters
#
# Document parameters here.
#
# [*ntp_servers*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*enc_ntp_servers*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
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
#  class { 'apache':
#    ntp_servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class apache {

    # set all parameters in a reusable location
    include ::apache::params

    $webroot = "${apache::params::apache_default_root}"

    # install apache package
    package { "${apache::params::apache_pkg}":
        ensure  =>  installed,
    }

    # enable apache service
    service { "${apache::params::apache_svc}":
        enable  =>  true,
        ensure  =>  running,
        #restart =>  "/sbin/service ${apache::params::apache_svc} graceful",
        require =>  Package["${apache::params::apache_pkg}"],
    }

    # create vhosts configuration directory, used by apache conf
    file { "${apache::params::vhosts_conf_dir}":
        ensure  =>  directory,
        recurse =>  false,
        owner   =>  root,
        group   =>  root,
        mode    =>  0755,
        require =>  Package["${apache::params::apache_pkg}"],
    }

    # install default httpd.conf
    file { "${apache::params::apache_conf}":
        ensure  =>  present,
        mode    =>  0644,
        owner   =>  root,
        group   =>  root,
        content =>  template("${apache::params::apache_conf_erb}"),
        require =>  Package["${apache::params::apache_pkg}"],
        notify  =>  Service["${apache::params::apache_svc}"],
    }

    # remove the default "welcome.conf" file
    file { "${apache::params::remove_welcome}":
        ensure  =>  absent,
        owner   =>  root,
        group   =>  root,
        mode    =>  0644,
        require =>  Package["${apache::params::apache_pkg}"],
        notify  =>  Service["${apache::params::apache_svc}"],
    }


}
