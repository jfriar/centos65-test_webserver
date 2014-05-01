# == Class: apache::php
#
# Install php as an optional component of apache.
#
# === Parameters
#
# None.
#
# === Variables
#
# None.
#
# === Actions
#
# - installs php
# - notifies apache service
#
# === Requires
#
# - apache::params
#
# === Examples
#
#  include ::apache::php
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class apache::php {

    include ::apache::params

    # install php package
    package { "${apache::params::php_pkg}":
        ensure  =>  installed,
        notify  =>  Service["${apache::params::apache_svc}"],
    }

}
