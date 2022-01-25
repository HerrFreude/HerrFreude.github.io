#!/bin/sh
# A small script to show whatspoppin

# Shows wich OS is running
os=$(lsb_release -sd) #Volksystem9

# Shows current user name
user=$(id -un)

while :
do
zeit=$(date +%R)
tag=$(date +%a)
monat=$(date +%b)
jahr=$(date +%Y)

# Checks if webcam is blacklisted
cam () {
if grep -q "blacklist uvcvideo" /etc/modprobe.d/blacklist.conf; then
	echo "-"
else
	echo "+"
fi
}

# Checks if microphone is blacklisted
mic () {
if grep -q "blacklist snd_usb_audio" /etc/modprobe.d/blacklist.conf; then
	echo "-"
else
	echo "+"
fi
}

# Checks if web connection is of exists
web () {
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	echo "+"
else
	echo "-"
fi
}

# Shows ram usage
mem () {
free -m | awk 'NR==2{printf "Mem: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
}

# Checks for battery percent, if no battery display 0
# cat /sys/class/power_supply/BAT0/capacity
battery () {
if [ -f /sys/class/power_supply/BAT0/capacity ]
then
	cat /sys/class/power_supply/BAT0/capacity 
else
	echo "0"
fi
}

clear
printf '%s\n' "${tag} ${monat} ${jahr} ${zeit} ${user}
 
[$(mic)] [$(cam)] [ ] [$(web)] [$(battery)]
mic cam eth web bat

$(mem)" 
sleep 60s
done
