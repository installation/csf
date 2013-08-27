ConfigServer Security & Firewall
================================

Install ConfigServer Security & Firewall

Installs all dependencies using apt or yum

Tested on:
* CentOS 5.8/6.4
* Debian 6.0/7.0
* Fedora 17
* Ubuntu 10.04/12.04/12.10

Default temp dir is ````/tmp/csf````, this can be changed in install script.

By default, the installer logs into ````$TMP/install.log```` and ````$TMP/error.log````. Check these for further info about the installation process.

## Dependencies
* Package manager (apt or yum)
* HTTP Client (curl, wget or fetch)
* TAR executable
* Perl
* Perl GD library (Debian/Ubuntu: libgd-graph-perl, RHEL: perl-GDGraph)

Dependencies will be installed during the progress, but installing them on your own is advised.

## Installation

* Download and run ````install.sh````
* OPTIONAL: Log in to Webmin and install the CSF module from /usr/local/csf/csfwebmin.tgz

### Offline installation

Clone this repository or download ````install.sh```` and download the following file manually into the install script path:

[CSF Archive](http://configserver.com/free/csf.tgz)

Run ````install.sh````


You may find some error messages in the log about ````apf````. If you don't know what apf is or you don't have apf installed just ignore these messages.

For further info check [Official website](http://configserver.com/cp/csf.html) or [Installation notes](http://configserver.com/free/csf/install.txt)