#
# == Class: remmina::params
#
# Define some variables based on the operating system
#
class remmina::params {

    include os::params

    case $::osfamily {
        'Debian': {
             $package_name = 'remmina'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
