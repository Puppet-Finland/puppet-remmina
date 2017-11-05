# remmina

A Puppet module for managing Remmina, a GTK+ remote desktop client

# Module usage

This module has two entrypoints:

* [Class: remmina](manifests/init.pp)
* [Define: remmina::userconfig](manifests/userconfig.pp)
* [Define: remmina::connection](manifests/connection.pp)

Typically you would pass all the remmina::userconfig resources to the main class 
via $userconfigs hash parameter.

Note that the remmina::connection define only manages a subset of remmina 
connection details. This has the benefit that the some settings like 
"window_maximize" can be switched on and off using the Remmina GUI. The downside 
is that a connection will not work until it has been saved in the Remmina GUI 
and all the configuration keys are in place.

Note that on Debian 9 remmina is only available from Debian Backports. Because
of this module by default includes both ::apt and ::apt::backports on that
platform. You can disable this functionality by passing
$manage_backports = false to the main class.

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Ubuntu 12.04
* Ubuntu 14.04
* Debian 8
* Debian 9
* Fedora 21

The following operating systems should work out of the box or with small 
modifications:

* FreeBSD

For details see [params.pp](manifests/params.pp).
