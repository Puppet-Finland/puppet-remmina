# == Class: remmina
#
# This class install and configures Remmina, a GTK+ remote desktop client.
#
# == Parameters
#
# [*manage*]
#   Manage Remmina using this module. Valid values 'yes' (default) and 'no'. 
# [*manage_config*]
#   Manage Remmina's configuration using Puppet. Valid values 'yes' (default) 
#   and 'no'.
# [*manage_backports*]
#   Enable Debian Backports on Debian 9. Valid values are true (default) and 
#   false.
# [*plugins*]
#   An array of plugins to install. Undefined by default. Valid values are 
#   'gnome', 'nx', 'rdp', 'telepathy', 'vnc' and 'xdmcp'. At least on Debian 
#   some of these get pulled in automatically as dependencies.
# [*userconfigs*]
#   A hash of remmina::userconfig resources to realize.
#
# == Examples
#
# A Hiera example:
#
#   ---
#   classes:
#       - remmina
#
#   remmina::plugins:
#       - 'rdp'
#       - 'vnc'
#
#   remmina::userconfigs:
#       john:
#           # Uncomment to remove the defined connections
#           # ensure: 'absent'
#           connections:
#               azure:
#                   server: 'company.cloudapp.net:63034'
#                   loginname: 'johndoe'
#                   enc_password: '<encrypted_pass>'
#                   group: 'Work'
#               win2008:
#                   server: 'win2008.domain.com'
#                   loginname: 'Administrator'
#                   enc_password: '<encrypted_pass>'
#                   group: 'Work'
#                   security: 'rdp'
#
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class remmina
(
    $manage = 'yes',
    $manage_config = 'yes',
    Boolean $manage_backports = true,
    $plugins = undef,
    $userconfigs = {}

) inherits remmina::params
{

if $manage == 'yes' {

    class { '::remmina::install':
        manage_backports => $manage_backports,
        plugins          => $plugins,
    }

    if $manage_config == 'yes' {
        create_resources('remmina::userconfig', $userconfigs)
    }
}
}
