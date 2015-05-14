#
# == Define: remmina::install::plugin
#
# Install a Remmina plugin
#
define remmina::install::plugin {

    include ::remmina::params

    package { "${::remmina::params::plugin_package_basename}-${title}":
        ensure => installed,
    }

}
