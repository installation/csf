#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo -e "\033[34mThis script must be run as root\033[0m" 1>&2
   exit 1
fi

DIR=$(cd `dirname $0` && pwd)

echo -e "\033[34m###### Installing ConfigServer Security & Firewall 4.2 ######\033[0m"

install() {
	cd /tmp
	rm -rf csf.tgz
	wget http://configserver.com/free/csf.tgz
	tar -xzf csf.tgz
	cd csf
	sh install.sh
	sh /etc/csf/remove_apf_bfd.sh
	echo -e "\033[34m###### Checking installation ######\033[0m"
	perl /etc/csf/csftest.pl
	rm -rf csf.tgz
	sudo apt-get install libgd-graph-perl
}

uninstall() {
	cd /etc/csf
	sh uninstall.sh
}

case "$1" in
	install)
		install
		;;
	uninstall)
		uninstall
		;;
	reinstall)
		uninstall
		install
		;;
	*)
		echo "Usage: sudo ./csf.sh {install|uninstall|reinstall}" >&2
		exit 1
		;;
esac