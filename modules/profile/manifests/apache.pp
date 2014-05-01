# == Class: profile::apache
#
# Default classes to apply for all our apache hosts.
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
# - includes apache class
#
# === Requires
#
# - apache
#
# === Examples
#
#  include ::profile::apache
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class profile::apache {

    include ::apache

}
