# == Class: remmina::install
#
# This class installs Remmina
#
class remmina::install
(
    Boolean                 $manage_backports,
    Optional[Array[String]] $plugins

) inherits remmina::params {

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
