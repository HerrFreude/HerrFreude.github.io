#!/bin/bash

# THIS IS A GENERAL HARDENING SCRIPT FOR DEBIAN BASE SYSTEMS
# More hardening rescourcess:
# https://vez.mrsk.me/linux-hardening.html
# https://tails.boum.org/blueprint/harden_AppArmor_profiles/
# Of course many things in here can kill your system BEAWARE

# Update the system
sudo apt-get update
sudo apt-get upgrade 

# Disable all wireless devices via  software(not hardware blocked)
sudo rfkill block all # rfkill list shows if everything is blocked

# Setup basic ufw firwall
# It could be hardened mor by only allowing output to the DNS server for browsing
sudo apt-get install ufw
ufw logging off # Turns of logging cause I never read them anyway
sudo ufw default deny incoming # Disables all incoming connections, even SSH
sudo ufw default deny forwarding # Disables forwarding, cause this is not a router
sudo systemctl enable ufw
sudo ufw enable

# Enable apparmor and securing
sudo apt-get install apparmor-profiles apparmor-utils
sudo aa-enforce /etc/apparmor.d/* # This should enforce all basic rules

# Setup sandboxing with firejail
# sudo apt-get install firejail

# Disable listining for open Printers
sudo systemctl disable cups-browsed

# Disable apple device communication
sudo systemctl disable avahi-daemon

# Inserting hosts blocklist into the hosts file and "activating"
#git clone https://github.com/StevenBlack/hosts/blob/master/hosts 
#sudo cat hosts >> /etc/hosts
#sudo service network-manager restart

echo "Basic hardening finished..."
echo "To further hardening encrypt the disk,"
echo "and dont forget to harden the BIOS"
