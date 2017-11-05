# == Class: remmina::install
#
# This class installs Remmina
#
class remmina::install
(
    $manage_backports,
    $plugins

) inherits remmina::params {

    # When we're ready to drop Puppet 3.x support we can validate the array contents using $plugins.each
    # |$plugin| { ... }.
    validate_array($plugins)

    if $::lsbdistcodename == 'stretch' {
        if $manage_backports {
            include ::apt
            include ::apt::backports
        }
        $package_require = Class['::apt::backports']
    } else {
        $package_require = undef
    }

    package { $::remmina::params::package_name:
        ensure  => installed,
        require => $package_require,
    }

    if $plugins {
        remmina::install::plugin { $plugins: }
    }
}
