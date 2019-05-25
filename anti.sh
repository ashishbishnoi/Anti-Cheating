#!/bin/bash
set -e
#Check whether the user is root
if [[ $EUID -ne 0 ]];
then
	echo "This script must be run as root" 1>&2
	exit 1
fi

#Check if the udev rule file exist
u_rule="/etc/udev/rules.d/10-usbmount.rules"

if [ ! -f $u_rule ]
then
	printf 'KERNEL=="sd*[!0-9]|sr*", ENV{ID_SERIAL}!="?*", SUBSYSTEMS=="usb", RUN+="/usr/bin/usbdevinserted"' > $u_rule 
fi

#Check wheteher the sound file exist
s_file="/etc/anti/alarm.wav"
if [ ! -f $s_file ]
then
	echo "Error:Alarm sound does not exist"
	exit 1
fi

#Unmuting Pulseaudio and Alsa and Setting Sound to Maximum
amixer sset Master unmute 1>/dev/null
amixer sset Master 100% 1>/dev/null
sudo -u tux amixer -D pulse sset Master unmute 1>/dev/null
sudo -u tux amixer -D pulse sset Master 100% 1>/dev/null

#Playing the Alert
while true; do
sudo -u tux paplay $s_file
done
