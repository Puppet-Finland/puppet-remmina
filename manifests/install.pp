# == Class: remmina::install
#
# This class installs Remmina
#
class remmina::install inherits remmina::params {

    package { $::remmina::params::package_name:
        ensure => installed,
    }
}
