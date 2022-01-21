#!/bin/bash
clear
kaktus=$(tput setaf 108)
text=$(tput setaf 254)
flower=$(tput setaf 5)

packages=$(dpkg-query -l | wc -l)

distro=$(lsb_release -sd)

user=$(id -un)
host=$(hostname)

tim=$(date +'%H:%M')
printf '%s\n' "
 ${kaktus}     __ ${flower}\:/${kaktus}           ${kaktus}${user}${text}@${kaktus}${host}
    \-  /  -/          ${kaktus}os	${text}Debian${kaktus}
  \/     \   \ .       ${kaktus}wm	${text}${wm}cwm${kaktus}
   \  ${text}O . O${kaktus}  :/        ${kaktus}pkgs	${text}${packages}${kaktus}
   \  /   .,  /         
"     
#${kaktus}Read desert 🌵🔥🌲"
