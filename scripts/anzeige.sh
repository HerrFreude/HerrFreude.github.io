#!/bin/sh
# A small script to show whatspoppin
# 65
green=$(tput setaf 28)
sgr=$(tput sgr0)

# Shows wich OS is running
os=$(lsb_release -sd) #Volksystem9

# Shows current user name
user=$(id -un)

while :
do
zeit=$(date +%R)
tag=$(date +%a)
monatstag=$(date +%d)
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
free -m | awk 'NR==2{printf "%s/%s\n", $3,$2 }'
}

# Checks for battery percent, if no battery display 0
battery () {
if [ -f /sys/class/power_supply/BAT0/capacity ]
then
	cat /sys/class/power_supply/BAT0/capacity
# If it is above 20% echo "▇"; if under 20% echo "▂"
else
	echo "0"
fi
}

clear
printf '%s\n' "${tag} ${monatstag}. ${monat} ${jahr} ${zeit} ${user} ${green}🌲${sgr}
 
[$(mic)] [$(cam)] [ ] [$(web)] [$(battery)] [$(mem)]
mic cam eth web bat mem" 
sleep 60s
done
