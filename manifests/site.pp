# == Manifest: site
#
# A very basic site manifest which autoloads a single role,
# based on a facter "role" variable, which is defined in
# the Vargrantfile.
#
node default {
    notify { "this is a ${::role}": }
    include "::role::${::role}"
}
