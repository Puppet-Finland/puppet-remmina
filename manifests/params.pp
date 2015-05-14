#
# == Class: remmina::params
#
# Define some variables based on the operating system
#
class remmina::params {

    include ::os::params

    case $::osfamily {
        'Debian': {
            $package_name = 'remmina'
            $plugin_package_basename = 'remmina-plugin'
        }
        'RedHat': {
            $package_name = 'remmina'
            $plugin_package_basename = 'remmina-plugins'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
