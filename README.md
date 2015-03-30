# remmina

A Puppet module for managing Remmina, a GTK+ remote desktop client

# Module usage

This module has two entrypoints:

* [Class: remmina](manifests/init.pp)
* [Define: remmina::connection](manifests/connection.pp)

Typically you would pass all the remmina::connection resources to the main class 
via $connections hash parameter.

Note that the remmina::connection define only manages a subset of remmina 
connection details. This has the benefit that the some settings like 
"window_maximize" can be switched on and off using the Remmina GUI. The downside 
is that a connection will not work until it has been saved in the Remmina GUI 
and all the configuration keys are in place.

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Ubuntu 14.04

The following operating systems should work out of the box or with small 
modifications:

* Debian
* RedHat/CentOS
* FreeBSD

For details see [params.pp](manifests/params.pp).
