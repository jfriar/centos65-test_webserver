# == Class: profile::base
#
# Full description of class profile::base here.
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
#  class { 'profile::base':
#    ntp_servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class profile::base {

    case $::operatingsystem {
        centos, redhat: {
            $firewall = 'iptables'
        }
        default: { fail("Unrecognized OS: ${::operatingsystem}") }
    }

    service { $firewall:
        enable  =>  false,
        ensure  =>  stopped,
    }

}
