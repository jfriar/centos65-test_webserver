# == Class: profile::apache::php::test_webserver
#
# Full description of class profile::apache here.
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
#  class { 'profile::apache':
#    ntp_servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class profile::apache::php::test_webserver inherits profile::apache::php {

    # create the web root that all sites will be in
    $web_root = '/web'

    file { $web_root:
        ensure  =>  directory,
        owner   =>  root,
        group   =>  root,
        mode    =>  0755,
    }

    # setup the virtual hosts
    $web_root_default = "${web_root}/default"
    $web_root_localhost_81 = "${web_root}/localhost_81"

    apache::vhost { "default":
        docroot =>  $web_root_default,
        port    =>  '80',
        require =>  File[$web_root],
    }
    apache::vhost { "localhost_81":
        docroot =>  $web_root_localhost_81,
        port    =>  '81',
        require =>  File[$web_root],
    }

    # create default content
    $default_content = "<html>\n    <body>\n    <?php\n        phpinfo();\n    ?>\n    </body>\n</html>"
    file { "${web_root_default}/index.php":
        ensure  =>  present,
        owner   =>  root,
        group   =>  root,
        mode    =>  0644,
        content =>  $default_content,
        require =>  File[$web_root_default],
    }

    # create default content
    $localhost_81_content = "<html>\n    <body>\n    <p>\nHello world!\n    </p>\n    </body>\n</html>"
    file { "${web_root_localhost_81}/index.html":
        ensure  =>  present,
        owner   =>  root,
        group   =>  root,
        mode    =>  0644,
        content =>  $localhost_81_content,
        require =>  File[$web_root_localhost_81],
    }

}
