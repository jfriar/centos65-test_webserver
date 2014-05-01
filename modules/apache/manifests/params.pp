# == Class: apache::params
#
# Default settings to use with the ::apache class.
# These are separated out from other parts of the apache
# module so that all parts of the apache module can use
# the same default settings.
#
# === Parameters
#
# These aren't parameters in the old, puppet < 3 sense, but
# are actually "sane" defaults to use with this apache module.
#
# [*apache_svc*]
#   The OS-specific apache service name.
#
# [*apache_pkg*]
#   The OS-specific apache package name.
#
# [*apache_conf*]
#   The OS-specific apache httpd.conf name (full path and filename).
#
# [*apache_conf_src*]
#   The OS-specific apache httpd.conf source file.
#
# [*remove_welcome*]
#   The OS-specific default apache configuration to remove.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# [*vhosts_conf_dir*]
#   The consistent directory location to store apache vhost configurations.
#   Files in this directory are automatically included as per this module's
#   apache_conf.
#
# [*vhosts_log_dir*]
#   The consistent directory location to store apache vhost logs.
#
# [*php_pkg*]
#   The OS-specific php package name.
#
# === Variables
#
# None.
#
# === Actions
#
# None.
#
# === Requires
#
# None.
#
# === Examples
#
#  include ::apache::params
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class apache::params {

    case $::operatingsystem {
        centos, redhat: {
            # apache defaults
            $apache_svc         = 'httpd'
            $apache_pkg         = 'httpd'

            $apache_conf        = '/etc/httpd/conf/httpd.conf'
            $apache_conf_src    = 'puppet:///modules/apache/httpd_el.conf'

            $remove_welcome     = '/etc/httpd/conf.d/welcome.conf'

            $vhosts_conf_dir    = '/etc/httpd/conf.d/vhosts'
            $vhosts_log_dir     = '/var/log/httpd'

            # php defaults
            $php_pkg            = 'php'
        }
        default: { fail("Unrecognized OS: ${::operatingsystem}") }
    }

}
