# == Class: profile::apache::php::test_webserver
#
# Configures a php/apache test webserver.
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
# - creates the web root
# - defines the vhosts to use for the test_webserver
# - installs index.php and index.html for vhost:80 and vhost:81
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
