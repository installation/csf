ConfigServer Security & Firewall install
========================================

Install Webmin on several Linux distributions with one script

* Installs all dependencies using apt or yum

Tested on:
* CentOS 5.8/6.4
* Debian 6.0/7.0
* Fedora 17
* Ubuntu 10.04/12.04/12.10/13.04

Default temp dir is ````/tmp/Webmin````, this can be changed in install script.

By default, the installer logs into ````$TMP/install.log```` and ````$TMP/error.log````. Check these for further info about the installation process.

## Installation

There are several ways to install Webmin

### Online installation

Clone this repository and run ````install.sh````

OR

Just download ````install.sh```` and run it.

### Offline installation

Download the appropriate package and install it with your package manager depending on your distribution:

##### Debian

[Webmin DEB package](http://prdownloads.sourceforge.net/webadmin/webmin_1.650_all.deb)

````dpkg --install webmin_1.650_all.deb````

If Debian complains about missing dependencies, install them with the command:

````apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python````

##### RHEL

[Webmin RPM package](http://prdownloads.sourceforge.net/webadmin/webmin-1.650-1.noarch.rpm)

````rpm -U webmin-1.650-1.noarch.rpm````

### Manual Installation
[Follow these instructions](http://www.webmin.com/tgz.html)



For further info check [Official website](http://www.webmin.com/)