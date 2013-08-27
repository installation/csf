#!/bin/bash

# Script to install ConfigServer Security & Firewall
# Author: Márk Sági-Kazár (sagikazarmark@gmail.com)
# This script installs CSF on several Linux distributions with Webmin.
#
# Version: 6.33

# Variable definitions
DIR=$(cd `dirname $0` && pwd)
NAME="ConfigServer Security & Firewall"
$SLUG="csf"
VER="6.33"
DEPENDENCIES=("perl" "tar")
TMP="/tmp/$SLUG"
INSTALL_LOG="$TMP/install.log"
ERROR_LOG="$TMP/error.log"


# Basic function definitions

## Echo colored text
e()
{
	local color="\033[${2:-34}m"
	local log="${3:-$INSTALL_LOG}"
	echo -e "$color$1\033[0m"
	log $1 $log
}

## Exit error
ee()
{
	local exit_code="${2:-1}"
	local color="${3:-31}"

	clear
	e "$1" "$color" $ERROR_LOG
	exit $exit_code
}

## Log messages
log()
{
	local log="${2:-$INSTALL_LOG}"
	echo $1 >> $log
}


# Cleaning up
rm -rf $TMP
mkdir -p $TMP
cd $TMP
chmod 777 $TMP

# Checking root access
if [ $EUID -ne 0 ]; then
	ee "This script has to be ran as root!"
fi

# CTRL_C trap
ctrl_c()
{
	clear
	echo
	echo "Installation aborted by user!"
	cleanup
}
trap ctrl_c INT

# Basic checks

## Check for wget or curl or fetch
e "Checking for HTTP client..."
if [ `which curl 2> /dev/null` ]; then
	download="$(which curl) -s -O"
elif [ `which wget 2> /dev/null` ]; then
	download="$(which wget) --no-certificate"
elif [ `which fetch 2> /dev/null` ]; then
	download="$(which fetch)"
else
	DEPENDENCIES+=("wget")
	download="$(which wget) --no-certificate"
	e "No HTTP client found, wget added to dependencies" 31
fi

## Check for package manager (apt or yum)
e "Checking for package manager..."
if [ `which apt-get 2> /dev/null` ]; then
	install="$(which apt-get) -y --force-yes install"
elif [ `which yum 2> /dev/null` ]; then
	install="$(which yum) -y install"
else
	ee "No package manager found."
fi

## Check for init system (update-rc.d or chkconfig)
e "Checking for init system..."
if [ `which update-rc.d 2> /dev/null` ]; then
	init="$(which update-rc.d)"
elif [ `which chkconfig 2> /dev/null` ]; then
	init="$(which chkconfig) --add"
else
	ee "Init system not found, service not started!"
fi


# Function definitions

## Install required packages
install()
{
	if [ -z "$1" ]; then
		e "Package not given" 31
		return 1
	else
		e "Installing package: $1"
		$install "$1" >> $INSTALL_LOG 2>> $ERROR_LOG || ee "Error during install $1"
		e "Package $1 successfully installed"
	fi

	return 0
}

## Download required file
download()
{
	if [ -z "$1" ]; then
		e "No download given" 31
		return 1
	else
		$download "$1" >> $INSTALL_LOG 2>> $ERROR_LOG || ee "Error during download $2"
	fi

	return 0
}

## Install init script
init()
{
	if [ -z "$1" ]; then
		e "No init script given" 31
		return 1
	else
		$init "$1" >> $INSTALL_LOG 2>> $ERROR_LOG || ee "Error during init"
	fi

	return 0
}

## Show progressbar
progress()
{
	local progress=${1:-0}
	local gauge="${2:-Please wait}"
	local title="${3:-Installation progress}"

	echo $progress | dialog --backtitle "Installing $NAME $VER" \
	 --title "$title" --gauge "$gauge" 7 70 0
}

## Cleanup files
cleanup()
{
	rm -rf $TMP/supervisor* $TMP/setuptools*
}


# Checking dependencies
for dep in ${DEPENDENCIES[@]}; do
	if [ ! $(which $dep 2> /dev/null) ]; then
		install "$dep"
	fi
done

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