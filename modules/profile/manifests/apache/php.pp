# == Class: profile::apache::php
#
# Installs php for use with apache
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
# - installs php
#
# === Requires
#
# - profile::apache
#
# === Examples
#
#  include ::profile::apache::php
#
# === Authors
#
# John Friar <jfriar@gmail.com>
#
class profile::apache::php inherits profile::apache {

    include ::apache::php

}
