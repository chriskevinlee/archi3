Key Bindings
------------

Superkey+d 				#Open Application Launcher
SuperKey+f				#Put Selected Window in full Screen
SuperKey+NUMBER			#Move/Add Workspace
SuperKey+ARROW			#Select Focus Window
SuperKey+r 				#Resize Selected Window
SuperKey+e 				#Switch Between horizontal and vertical layout
SuperKey+s 				#Switch Between stack layout
SuperKey+w 				#Switch Between tab Layout
SuperKey+ENTER			#Open Alacritty Terminal

SuperKey+Shift+q		#Closes Selected Window
SuperKey+Shift+NUMBER	#Moves Selected Window to Another Workspace 1-0
SuperKey+Shift+e 		#Open Power Menu
SuperKey+Shift+s 		#Open SSH Menu
SuperKey+Shift+r 		#Reload i3 Configuration
SuperKey+Shift+ARROW	#Moves Selected Window 
SuperKey+Shift+Space 	#Toggle floating mode for Selected Window then 
						#hold SuperKey and use mouse to drag Selected window if there is no title bar
Alt+b 					#Open Brave Web Browser
Alt+f 					#Open Firefox Web Browser

F1						#Tilda Dropdown Terminal


Configurations
--------------
/$HOME/.config/i3/config 					#i3wm Configuration

/$HOME/.config/polybar/launch.sh 			#Polybar launcher script
/$HOME/.config/polybar/config.ini			#Polybar configuration, this includes modules that are on
											#the bar and any modules that linked to scripts in /$HOME/.config/scripts

/$HOME/.config/nitrogen/wallpapers/			#Wallpaper Packs

/$HOME/.config/rofi/chrislee_dark.rasi		#Rofi theme configurarion
/$HOME/.config/rofi/config.rasi				#Points to chrislee_dark.rasi Rofi theme configurarion

/$HOME/.config/tilda/config_0				#Configuration for Tilda Dopdown Terminal

/$HOME/.config/scripts/feh_wallpaper.sh 	#Script to randomize and apply a wallpaper, use contab -e
											#to uncomment and edit how often you would lke to apply a
											#random wallpaper 

/$HOME/.config/scripts/nmcli.sh 			#NetworkManager script to show if you are connected to 
											#ethernet, wifi or disconected

/$HOME/.config/scripts/power.sh 			#Power Menu to Lock,Logout,Reboot or PowerOff

/$HOME/.config/scripts/rofi-wifi-menu.sh 	#Wifi rofi menu created by Eric Murphy
											#YouTube:youtube.com/watch?v=v8w1i3wAKiw
											#GitHub:github.com/ericmurphyxyz/rofi-wifi-menu

/$HOME/.config/scripts/ssh_connections.sh 	#SSH Menu to allow quick access to connect to a machine over ssh
											#Edit this file accordingly