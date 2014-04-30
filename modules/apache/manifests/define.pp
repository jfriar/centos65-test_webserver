# == Define: example_resource
#
# Full description of defined resource type example_resource here.
#
# === Parameters
#
# Document parameters here
#
# [*namevar*]
#   If there is a parameter that defaults to the value of the title string
#   when not explicitly set, you must always say so.  This parameter can be
#   referred to as a "namevar," since it's functionally equivalent to the
#   namevar of a core resource type.
#
# [*basedir*]
#   Description of this variable.  For example, "This parameter sets the
#   base directory for this resource type.  It should not contain a trailing
#   slash."
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
# Provide some examples on how to use this type:
#
#   example_class::example_resource { 'namevar':
#     basedir => '/tmp/src',
#   }
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
define example_class::example_resource($basedir) {
    case $::operatingsystem {
        centos, redhat: {
            $sshd_svc = 'sshd'
            $sshd_pkg = 'openssh-server'
            $ssh_pkg = 'openssh-clients'
            $sshd_conf = '/etc/ssh/sshd_config'
            $ssh_conf = '/etc/ssh/ssh_config'
            case $::operatingsystemrelease {
                /^6\.[0-9]+$/: { $vm_dist = 'rhel6' }
                /^5\.[0-9]+$/: { $vm_dist = 'rhel5' }
                default: { fail("Unhandled ${::operatingsystem} release: ${::operatingsystemrelease}") }
            }
            case $::architecture {
                x86_64: { $vm_arch = 'x86_64' }
                default: { $vm_arch = 'i386' }
            }
        }
        default: { fail("Unrecognized OS: ${::operatingsystem}") }
    }
}
