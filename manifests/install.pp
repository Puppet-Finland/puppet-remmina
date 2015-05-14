# == Class: remmina::install
#
# This class installs Remmina
#
class remmina::install
(
    $plugins

) inherits remmina::params {

    # When we're ready to drop Puppet 3.x support we can validate the array contents using $plugins.each
    # |$plugin| { ... }.
    validate_array($plugins)

    package { $::remmina::params::package_name:
        ensure => installed,
    }

    if $plugins {
        remmina::install::plugin { $plugins: }
    }
}
