#/bin/sh
# This is my general Debian install script
# It installs the basic utils I need + downloads my dotfiles
# And enforces some general security setings

echo "Welcome to your lazy Dabian setup script."
echo "*****************************************"

echo "making system ready..."
cd ~
sudo apt-get update
sudo apt-get upgrade
echo "done"

echo "installing basic utils..."
sudo apt-get install -yy git alsa-utils neovim
echo "done" 

echo "installing office utils..."
sudo apt-get install -yy pandoc aspell aspell-de aspell-en
echo "done" 

echo "installing multimedia utils..."
sudo apt-get install -yy zathura sxiv ffmpeg firefox
echo "done" 

echo "installing windowmanager..."
sudo apt-get install -yy xorg cwm
echo "done" 

echo "creating directorys..."
cd ~
mkdir dox
mkdir ~/dox/Unterlagen
mkdir dl
mkdir pix
mkdir mus
echo "done"

echo "downloading your configs..."
cd ~
git clone sume.github.git/user/HerrFreude.github.io
cp ~/HerrFreude.github.io/configs/ ~/config
cd ~
echo "done"

echo "putting configs in the right place"
cd ~ 
mv ~/config/bash/bashrc ~/.bashrc
mv ~/config/bash/bash_aliases ~/bash_aliases
mv ~/config/bash/profile ~/.profile
mv ~/config/bash/bash_logout ~/.bash_logout
mv ~/config/x11/xinitrc ~/.xinitrc
mv ~/config/x11/Xresources ~/.Xresources
mv ~/config/cwm/cwmrc ~/.cwmrc
mv ~/config/vim/vimrc ~/.vimrc


echo "done"

echo "Hardening your System"
echo "*********************"

echo "installing and setting-up firewall with ufw..."
sudo apt-get install -yy ufw
ufw logging off
sudo systemctl enable ufw
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default deny forwarding
sudo ufw default deny outgoing
sudo ufw allow out to any port 80
sudo ufw allow out to any port 443
sudo ufw allow out to any port 67 # dhcp
sudo ufw allow out to any port 68 # dhcp
sudo ufw allow out to any port 53 # connecting to DNS Servers
sudo ufw reload
echo "done"

echo "installing mandatory excess controll with apparmor..."
sudo apt-get -yy install apparmor apparmor-profiles apparmor-utils
sudo aa-enforce /etc/apparmor.d/* # enforces all apparmor profiles for 
# it misses the step to enable apparmor in grub !!!
echo "done"

echo "installing sandboxing with firejail..."
sudo apt-get -yy install firejail
sudo firecfg # enable firejai profiles for installed programms
sudo aa-enforce firejail-default # loads firejail apparmor profiles into the kernel
echo "done"

echo "disable Webcam..."
sudo sh -c "echo 'blacklist uvcvideo' >> /etc/modpreobe.d/blacklist.conf"
echo "done" 

echo "disable listining for open printers..."
sudo systemctl disable cups-browsed
echo "done"

echo "disable aplle device communication..."
sudo systemctl disable avahi-deamon
echo "done"

echo "stop xserver listining on port 6000"
cd ~
touch .xserverrc
sudo sh -c "echo 'exec X -nolisten tcp' >> .xserverrc"
echo "done"

echo "change executable premissions..."
umask 077 # at best put 007 into the .profile file, for a multiuser system
echo "done"

echo "System is ready, you lazy rectum!"
done
