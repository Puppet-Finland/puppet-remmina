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
# [*connections*]
#   A hash of remmina::connection resources to realize.
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
    $connections = {}

) inherits remmina::params
{

if $manage == 'yes' {

    include remmina::install

    if $manage_config == 'yes' {
        create_resources('remmina::connection', $connections)
    }
}
}
