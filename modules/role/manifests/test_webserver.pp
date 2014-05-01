# == Class: role::test_webserver
#
#  The role for the test webserver.
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
# None.
#
# === Requires
#
# - role
#
# === Examples
#
#  include ::role::test_webserver
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class role::test_webserver inherits role {

    include ::profile::apache::php::test_webserver

}
