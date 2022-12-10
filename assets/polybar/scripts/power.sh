#!/bin/sh

chosen=$(printf "Lock\nLogout\nReboot\nPowerOff\n" | rofi -p "Power" -dmenu -i -theme-str)

case "$chosen" in
        "Lock") 
    			yes_no=$(printf "no\nyes" | rofi -p "Would You Like to $chosen" -dmenu -i -theme-str)
    			case $yes_no in
        			[no]* ) exit;;
					[yes]* ) i3lock;;
    			esac;;
        "Logout") 
    			yes_no=$(printf "no\nyes" | rofi -p "Would You Like to $chosen" -dmenu -i -theme-str)
    			case $yes_no in
        			[no]* ) exit;;
        			[yes]* ) i3-msg exit;;
    			esac;;    			
    	"Reboot") 
    			yes_no=$(printf "no\nyes" | rofi -p "Would You Like to $chosen" -dmenu -i -theme-str)
    			case $yes_no in
        			[no]* ) exit;;
        			[yes]* ) reboot;;
    			esac;;
    	"PowerOff") 
    			yes_no=$(printf "no\nyes" | rofi -p "Would You Like to $chosen" -dmenu -i -theme-str)
    			case $yes_no in
        			[no]* ) exit;;
        			[yes]* ) poweroff;;
    			esac;;
esac
