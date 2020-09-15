# Set Wallpaper
feh --bg-fill ~/Downloads/wallpaper.jpg &

# Load .Xresources
xrdb -merge ~/.Xresources

# Dwm statusbar script
while true 
do
	#reset bar
	unset DATE BATT
	
	DATE="$(date +"%A, %d.%m.%Y - %H:%M")" # Display the current date
	BATT="$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )" # Display Battery status

	xsetroot -name "[ ${BATT} ][ ${DATE} ]"

	sleep 1m
done &
# Execute the dwm windowmanager
exec dwm
