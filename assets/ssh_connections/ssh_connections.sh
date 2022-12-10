#!/bin/sh

chosen=$(printf "Server1\nServer2\nServer3\nServer4\n" | rofi -p "SSH Connection" -dmenu -i -theme-str)

case "$chosen" in

# "Server1") 
#         yes_no=$(printf "no\nyes" | rofi -p "Connect to "$chosen"?" -dmenu -i -theme-str)
#         case $yes_no in
#         [no]* ) exit;;
#         [yes]* ) alacritty -e ssh USERNAME@IP-ADDRESS;;
#         esac;;

# "Server2")
#         yes_no=$(printf "no\nyes" | rofi -p "Connect to "$chosen"?" -dmenu -i -theme-str)
#         case $yes_no in
#         [no]* ) exit;;
#         [yes]* ) alacritty -e ssh USERNAME@IP-ADDRESS;;
#         esac;;

# "Server3")
#         yes_no=$(printf "no\nyes" | rofi -p "Connect to "$chosen"?" -dmenu -i -theme-str)
#         case $yes_no in
#         [no]* ) exit;;
#         [yes]* ) alacritty -e ssh USERNAME@IP-ADDRESS;;
#         esac;;

# "Server4")
#         yes_no=$(printf "no\nyes" | rofi -p "Connect to "$chosen"?" -dmenu -i -theme-str)
#         case $yes_no in
#         [no]* ) exit;;
#         [yes]* ) alacritty -e ssh USERNAME@IP-ADDRESS;;
#         esac;;

esac
