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
#   Login name on the remote server.
# [*group*]
#   The connection group to add this connection to. This only affects the 
#   connection listing in the Remmina GUI.
# [*enc_password*]
#   Encrypted password to use for logging in. It is easiest to derive this from 
#   a .remmina file created by Remmina itself. This parameter is optional.
# [*protocol*]
#   The protocol to use for the connection. Defaults to 'RDP'.
# [*security*]
#   Connection security. Valid values 'rdp', 'tls', 'nla'. If left empty, the 
#   security details are negotiated automatically, which may or may not work. 
#   Older Windows versions require this to be set to 'rdp'.
#
define remmina::connection
(
    $system_user,
    $server,
    $loginname,
    $group,
    $enc_password = undef,
    $protocol = 'RDP',
    $security = undef
)
{
    include ::remmina::params

    $remmina_conf_dir = "${::os::params::home}/${system_user}/.remmina"
    $connection_file = "${remmina_conf_dir}/${name}.remmina"

    $default_changes = [    "set remmina/name ${title}",
                            "set remmina/server ${server}",
                            "set remmina/username ${loginname}",
                            "set remmina/group ${group}",
                            "set remmina/protocol ${protocol}" ]

    if $security {
        $sec_changes = concat($default_changes, ["set remmina/security ${security}"])
    } else {
        $sec_changes = $default_changes
    }

    if $enc_password {
        $changes = concat($sec_changes, ["set remmina/password ${enc_password}"])
    } else {
        $changes = $sec_changes
    }

    augeas { "remmina-connection-${system_user}-${name}":
        context => "/files/${connection_file}",
        changes => $changes,
        lens    => 'Puppet.lns',
        incl    => $connection_file,
    }
}
