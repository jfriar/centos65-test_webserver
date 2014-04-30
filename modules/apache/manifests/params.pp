# == Class: apache::params
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
class apache::params {

    case $::operatingsystem {
        centos, redhat: {
            $apache_svc         = 'httpd'
            $apache_pkg         = 'httpd'
            $php_pkg            = 'php'

            $apache_conf        = '/etc/httpd/conf/httpd.conf'
            $apache_conf_erb    = 'apache/httpd_el.conf.erb'

            $apache_default_root = '/vagrant/www/default'

            $remove_welcome     = '/etc/httpd/conf.d/welcome.conf'

            $vhosts_conf_dir    = '/etc/httpd/conf.d/vhosts'
        }
        default: { fail("Unrecognized OS: ${::operatingsystem}") }
    }

}
