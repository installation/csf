ConfigServer Security & Firewall install
========================================

Install ConfigServer Security & Firewall on several Linux distributions with one script

* Installs all dependencies using apt or yum

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

Dependencies will be installed during the progress, but installing them on your own is advised.

## Installation

* Download and run ````install.sh````
* Log in to Webmin and install the CSF module from /usr/local/csf/csfwebmin.tgz


You may find some error messages in the log about ````apf````. If you don't know what apf is or you don't have apf installed just ignore these messages.

For further info check [Official website](http://configserver.com/cp/csf.html)