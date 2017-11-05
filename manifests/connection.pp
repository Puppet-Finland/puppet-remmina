#
# == Define: remmina::connection
#
# A defined resource for managing Remmina connections
#
# == Parameters
#
# [*title*]
#   The resource $title is used for the name of the .remmina file and as the 
#   connection name in Remmina GUI.
# [*system_user*]
#   The system user for whom the connection entry is created.
# [*server*]
#   Remote server address, with or without the port. For example 
#   "server.domain.com" or "server.domain.com:3389". Remmina normally 
#   auto-detects the correct port based on the protocol, so usually the hostname 
#   or IP-address suffices.
# [*loginname*]
#   Login name on the remote server. Defaults to undef.
# [*domain*]
#   The domain to login to. Defaults to undef.
# [*group*]
#   The connection group to add this connection to. This only affects the 
#   connection listing in the Remmina GUI.
# [*ensure*]
#   Status of this connection on the system. Valid values are 'present' 
#   (default) and 'absent'.
# [*enc_password*]
#   Encrypted password to use for logging in. It is easiest to derive this from 
#   a .remmina file created by Remmina itself. This parameter is optional. Note 
#   that the encrypted password is not necessarily portable. For example, a 
#   password that works fine on Debian 8 may not work on Fedora 21.
# [*protocol*]
#   The protocol to use for the connection. Defaults to 'RDP'.
# [*security*]
#   Connection security. Valid values 'rdp', 'tls', 'nla'. If left empty, the 
#   security details are negotiated automatically, which may or may not work. 
#   Older Windows versions require this to be set to 'rdp'.
#
define remmina::connection
(
    String                   $system_user,
    String                   $server,
    String                   $group,
    Enum['present','absent'] $ensure = 'present',
    Optional[String]         $loginname = undef,
    Optional[String]         $enc_password = undef,
    String                   $protocol = 'RDP',
    Optional[String]         $domain = undef,
    Optional[Enum['rdp','tls','nla']] $security = undef
)
{
    include ::remmina::params

    $remmina_conf_dir = "${::os::params::home}/${system_user}/.remmina"
    $connection_file = "${remmina_conf_dir}/${name}.remmina"

    $default_changes = [    "set remmina/name ${title}",
                            "set remmina/server ${server}",
                            "set remmina/group ${group}",
                            "set remmina/protocol ${protocol}" ]

    if $loginname {
        $loginname_changes = concat($default_changes, ["set remmina/username ${loginname}"])
    } else {
        $loginname_changes = $default_changes
    }

    if $domain {
        $domain_changes = concat($loginname_changes, ["set remmina/domain ${domain}"])
    } else {
        $domain_changes = $loginname_changes
    }

    if $security {
        $sec_changes = concat($domain_changes, ["set remmina/security ${security}"])
    } else {
        $sec_changes = $domain_changes
    }

    if $enc_password {
        $changes = concat($sec_changes, ["set remmina/password ${enc_password}"])
    } else {
        $changes = $sec_changes
    }

    # Manage the connection file contents with Augeas only if it's supposed to 
    # be 'present'.
    if $ensure == 'present' {
        augeas { "remmina-connection-${system_user}-${name}":
            context => "/files/${connection_file}",
            changes => $changes,
            lens    => 'Puppet.lns',
            incl    => $connection_file,
            require => File[$remmina_conf_dir],
            before  => File["remmina-connection-${system_user}-${name}"],
        }
    }

    # Set connection file permissions
    $ensure_connection = $ensure ? {
        'present' => undef,
        'absent'  => 'absent',
    }

    file { "remmina-connection-${system_user}-${name}":
        ensure => $ensure_connection,
        name   => $connection_file,
        owner  => $system_user,
        group  => $system_user,
        mode   => '0644',
    }
}
