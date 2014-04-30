#!/bin/bash

MODULE=$1

CLASSTXT="# == Class: example_class
#
# Full description of class example_class here.
#
# === Parameters
#
# Document parameters here.
#
# [*ntp_servers*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. \"Specify one or more upstream ntp servers as an array.\"
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*enc_ntp_servers*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. \"The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames.\" (Note,
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
#  class { 'example_class':
#    ntp_servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class example_class (
    \$rpm_root = '/src/pkgs/local/RPMS'
) {
    case \$::operatingsystem {
        centos, redhat: {
            \$sshd_svc = 'sshd'
            \$sshd_pkg = 'openssh-server'
            \$ssh_pkg = 'openssh-clients'
            \$sshd_conf = '/etc/ssh/sshd_config'
            \$ssh_conf = '/etc/ssh/ssh_config'
            case \$::operatingsystemrelease {
                /^6\.[0-9]+$/: { \$vm_dist = 'rhel6' }
                /^5\.[0-9]+$/: { \$vm_dist = 'rhel5' }
                default: { fail(\"Unhandled \${::operatingsystem} release: \${::operatingsystemrelease}\") }
            }
            case \$::architecture {
                x86_64: { \$vm_arch = 'x86_64' }
                default: { \$vm_arch = 'i386' }
            }
        }
        default: { fail(\"Unrecognized OS: \${::operatingsystem}\") }
    }
}"

DEFINETXT="# == Define: example_resource
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
#   referred to as a \"namevar,\" since it's functionally equivalent to the
#   namevar of a core resource type.
#
# [*basedir*]
#   Description of this variable.  For example, \"This parameter sets the
#   base directory for this resource type.  It should not contain a trailing
#   slash.\"
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
define example_class::example_resource(\$basedir) {
    case \$::operatingsystem {
        centos, redhat: {
            \$sshd_svc = 'sshd'
            \$sshd_pkg = 'openssh-server'
            \$ssh_pkg = 'openssh-clients'
            \$sshd_conf = '/etc/ssh/sshd_config'
            \$ssh_conf = '/etc/ssh/ssh_config'
            case \$::operatingsystemrelease {
                /^6\.[0-9]+$/: { \$vm_dist = 'rhel6' }
                /^5\.[0-9]+$/: { \$vm_dist = 'rhel5' }
                default: { fail(\"Unhandled \${::operatingsystem} release: \${::operatingsystemrelease}\") }
            }
            case \$::architecture {
                x86_64: { \$vm_arch = 'x86_64' }
                default: { \$vm_arch = 'i386' }
            }
        }
        default: { fail(\"Unrecognized OS: \${::operatingsystem}\") }
    }
}"

if [ -d "${MODULE}" ]; then
    echo "Module ${MODULE} already exists"
else
    echo "Creating default directories for: ${MODULE}"
    mkdir -p ${MODULE}/{files,lib,manifests,templates,tests}

    echo "Installing default init.pp"
    echo "${CLASSTXT}" > ${MODULE}/manifests/init.pp

    echo "Installing default define.pp"
    echo "${DEFINETXT}" > ${MODULE}/manifests/define.pp
fi
