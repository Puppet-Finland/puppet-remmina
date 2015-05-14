# == Define: remmina::userconfig
#
# Configure Remmina for a system user
#
# == Parameters
#
# [*system_user*]
#   The system user to configure remmina for. Defaults to resource $title.
# [*ensure*]
#   Whether this user's configurations should be 'present' (default) or 'absent'
# [*connections*]
#   Hash of remmina:connections resources to realize.
#
define remmina::userconfig
(
    $system_user = $title,
    $ensure = 'present',
    $connections = {}
)
{
    include ::remmina::params

    $basedir = "${::os::params::home}/${system_user}/.remmina"

    $ensure_dir = $ensure ? {
        'present' => directory,
        'absent' => 'absent',
        default => undef,
    }

    file { "remmina-${basedir}":
        ensure => $ensure_dir,
        name   => $basedir,
        owner  => $system_user,
        group  => $system_user,
        mode   => '0700',
    }

    $defaults = {
        'ensure'      => $ensure,
        'system_user' => $system_user,
    }

    create_resources('remmina::connection', $connections, $defaults)
}
