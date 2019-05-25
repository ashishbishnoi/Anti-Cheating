#!/bin/bash
set -e
#Check whether the user is root
if [[ $EUID -ne 0 ]]; 
then
        echo "This script must be run as root" 1>&2
        exit 1
fi

cp anti.sh /usr/bin/anti && chmod +x /usr/bin/anti
cp 10-usbmount.rules /etc/udev/rules.d/
mkdir /etc/anti && cp alarm.wav /etc/anti/
