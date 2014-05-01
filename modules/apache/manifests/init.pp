# == Class: apache
#
# Installs apache web server package and installs a basic configuration
# that, without a vhost defined, doesn't listen on any ports.  The
# configuration makes minimal changes to RHEL/CentOS's default httpd.conf.
#
# === Parameters
#
# See apache::params
#
# === Variables
#
# None.
#
# === Actions
#
# - installs apache
# - creates a default location to auto-load vhost config files
# - removes default welcome.conf
# - ensure apache is running
#
# === Requires
#
# None.
#
# === Examples
#
#  include ::apache
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class apache {

    # set all parameters in a reusable location
    include ::apache::params

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
        source  =>  "${apache::params::apache_conf_src}",
        #content =>  template("${apache::params::apache_conf_erb}"),
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
