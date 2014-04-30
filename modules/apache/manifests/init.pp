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

    case $::operatingsystem {
        centos, redhat: {
            $apache_svc = 'httpd'
            $apache_pkg = 'httpd'
        }
        default: { fail("Unrecognized OS: ${::operatingsystem}") }
    }

    # install apache package
    package { $apache_pkg:
        ensure  =>  installed,
    }

    # enable apache service
    service { $apache_svc:
        enable  =>  true,
        restart =>  "/sbin/service ${apache_svc} graceful",
        require =>  Package["${apache_pkg}"],
    }

}
