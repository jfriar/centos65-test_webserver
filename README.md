# Test of vagrant, puppet, and centos 6.5 #

This sets up a very basic apache server, listening on
ports 80 and 81.

Vagrant will forward your machine's ports 8080 and 8081 to
the virtual machine's ports 80 and 81.

The puppet configurations use the [Role/Profile][] concept to help
abstract business function from technical implementation.

[Role/Profile]: http://www.craigdunn.org/2012/05/239/

## To use ##

1.  clone this git repo:

        git clone https://github.com/jfriar/centos65-test_webserver.git

2.  start the vagrant box:

        cd centos65-test_webserver
        vagrant up

3.  To access from the host machine:

    - [http://localhost:8080](http://localhost:8080)
    - [http://localhost:8081](http://localhost:8081)

