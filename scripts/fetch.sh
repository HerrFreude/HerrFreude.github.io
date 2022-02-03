#!/bin/bash
kaktus=$(tput setaf 28)
text=$(tput sgr0)
flower=$(tput setaf 204)
ntext=$(tput sgr0)


packages=$(dpkg-query -l | wc -l)
distro=$(lsb_release -sd)
user=$(id -un)
host=$(hostname)
shell=$(echo $SHELL)

mem () {
free -m | awk 'NR==2{printf "%s/%s\n", $3,$2}'
}

# Help prints info and syntax info
Help()
{
printf '%s\n' "
This is a small fetch script displaying systeminfo with diffrent ${kaktus}cacti${ntext}.

Syntax: fetch.sh [-h|s]
-h	Prints this help
-s      Prints a small cactus
        Prints a puffy like cactus
        
Take care, its a desert out there ${kaktus}🌵${ntext}."
}

# Normal fetch with a puffy like cactus
Normal () {
clear
printf '%s\n' "
 ${kaktus}     __ ${flower}\:/${kaktus}       ${kaktus}${user}${text}@${kaktus}${host}
    \-  /  -/      ${kaktus}os	${text}${distro}${kaktus}
  \/     \   \ .   ${kaktus}wm	${text}${wm}cwm${kaktus}
   \  ${text}O . O${kaktus}  :/    ${kaktus}pkgs	${text}${packages}${kaktus}
   \  /   .,  /    ${kaktus}mem  ${text}$(mem)
"     
}

# Small fetch with a glanda like cactus
Small () {
printf '%s\' "
\:/;/  ${distro}
( ..)  ${wm}cwm
\__ /  ${shell}
       ${packages}
"
}

# Checks for options
while getopts :hs opt; do
  case $opt in
	h) Help ;;	  
	s) Small ;;
	\?) echo "There is no -$OPTARG option "'("fetch.sh -h" for help)' >&2
    	exit 1 ;;
  esac
done

# If no Option is passed display the Normal function
if [ $OPTIND -eq 1 ]; then Normal; fi
# Resets how many options have passed
shift $((OPTIND-1))

