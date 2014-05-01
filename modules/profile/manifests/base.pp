# == Class: profile::base
#
# The base configuration that all the hosts will get.
# Currently it just disables and stops the firewall.
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
# - stops and disables iptables
#
# === Requires
#
# None.
#
# === Examples
#
#  include ::profile::base
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
