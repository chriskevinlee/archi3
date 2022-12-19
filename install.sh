#!/bin/bash
cd_from_yay_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
script_dir=$(dirname $BASH_SOURCE)
script_file=$(basename $BASH_SOURCE)
clear
echo "WARNING! This script is intended for new Arch Linux Installs running this script may brake or cause conficks."
read -r -p "Please Enter (YES! do as i say) without brackets to continue or enter n to exit " yesdoisay

while [[ $yesdoisay != "YES! do as i say" ]] && [[ $yesdoisay != "n" ]]; do
	clear
	echo "WARNING! This script is intended for new Arch Linux Installs running this script may brake or cause conficks."
	read -r -p "Please Enter (YES! do as i say) without brackets to continue or enter n to exit " yesdoisay
done

if [[ $yesdoisay = "YES! do as i say" ]]; then
	clear
	PS3="Please choose a number: "
	echo "======================================================================================================="
	echo "Main Menu: Following the script in order to install i3 Window Manager with ChrisKevinLee Configurations"
	echo "======================================================================================================="
	echo "                                                                                                       "

	options=("Update System" "Add Sudo User" "Install i3 with Requirements" "Install Packages" "Reboot" "Poweroff" "Exit Script")

	select main in "${options[@]}"
	 do
		case $main in
			"Update System" )
				### This block of code is setting a hostname/website to ping in a variable and sending the output of ping 
				### to /dev/null and then giving a exit code
				HOST=archlinux.org
				ping -c 2 $HOST 1>/dev/null 2>/dev/null
				EXIT_CODE=$?
				### If exit code is 0 then there is a active internet connection and will enable NetworkManager to start with the system and run updates.
				if [[ $EXIT_CODE = 0 ]]; then
					systemctl enable NetworkManager
					pacman --noconfirm -Syu
					wait
					clear
				### If exit code is 2 it will enable, start and then run updates
				elif [[ $EXIT_CODE = 2 ]]; then
					echo "Starting NetworkManager and Updating"
					sleep 3
					systemctl enable NetworkManager
					sleep 5  #Sleep command was added as it seems it would not run pacman -Syu this maybe because it takes a few seconds to get a ip
					systemctl start NetworkManager
					sleep 10  #Sleep command was added as it seems it would not run pacman -Syu this maybe because it takes a few seconds to get a ip
					pacman --noconfirm -Syu
					clear
				fi
				;;
			"Add Sudo User" )
				### This block of code will ask the user would they like to create a sudo user, if the user selects "y"
				### then the function "add_sudo_user" will run. The "sed -i" command will uncomment the "wheel" group in
				### in the sudoers file so that any user is placed in the "wheel" group can use sudo.
				read -r -p "Would you like to create a sudo user? (y/n): " create_sudo_user
				while [[ $create_sudo_user != y ]] && [[ $create_sudo_user != n ]] ; do
					clear
					read -r -p "Would you like to create a sudo user? (y/n): " create_sudo_user
				done
				if [[ $create_sudo_user = y ]]; then
				function add_sudo_user {
					read -r -p "Please Create a sudo user, More accounts can be added after setup: " sudo_user
					useradd -m "$sudo_user"
					usermod -aG wheel "$sudo_user"
					passwd "$sudo_user"
					sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
				}
				## Command belows will run the function/commands above
				add_sudo_user
				clear
				fi
				;;
			"Install i3 with Requirements" )
				clear
				while [[ -z "$sudo_user" ]]; do
					echo "A valid user needs to be entered if AUR package needs to be installed"
					read -r -p "please enter a valid username? " sudo_user
				done
	 			clear
				while [[ ! -d /home/"$sudo_user" ]]; do
					echo "A valid user needs to be entered if AUR package needs to be installed"
					read -r -p "YOU MUST enter a valid username? " sudo_user
					clear
				done

				pacman -S --noconfirm i3
				# This block of code will check to see if .config directory does NOT exist then create a directory for sudo_user variable
				if [[ ! -d /home/"$sudo_user"/.config ]]; then
					mkdir /home/"$sudo_user"/.config
				fi

				# This block of code will check to see if i3 directory does NOT exist then create a directory for sudo_user variable
				if [[ ! -d /home/"$sudo_user"/.config/i3/ ]]; then
					mkdir /home/"$sudo_user"/.config/i3/
				fi

				# This Block of code checks to see if i3 config file does NOT exist, if it does NOT exist then it will just copy config file from scirpt
				if [[ ! -f /home/"$sudo_user"/.config/i3/config ]]; then
					cp assets/i3/config /home/"$sudo_user"/.config/i3/config
				fi
				pacman -S --noconfirm sddm
				systemctl enable sddm
				cp -r assets/sddm/mount/ /usr/share/sddm/themes/
				cp assets/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf
				pacman -S --noconfirm qt5-quickcontrols2
				pacman -S --noconfirm qt5-graphicaleffects
				pacman -S --noconfirm qt5-svg

				pacman -S --noconfirm polybar
				if [[ ! -d /home/"$sudo_user"/.config/polybar ]]; then
					mkdir /home/"$sudo_user"/.config/polybar
					cp assets/polybar/config.ini /home/"$sudo_user"/.config/polybar/
					cp assets/polybar/launch.sh /home/"$sudo_user"/.config/polybar/
					chmod +x /home/"$sudo_user"/.config/polybar/launch.sh
				fi
				pacman -S --noconfirm pacman-contrib
				pacman -S --noconfirm pipewire-pulse
				pacman -S --noconfirm pavucontrol
				pacman -S --noconfirm ttf-font-awesome # icons for polybar
				pacman -S --noconfirm nm-connection-editor # network manager connection editor, run by right clicking on network icon in polybar

                pacman -S --noconfirm rofi
                if [[ ! -d /home/"$sudo_user"/.config/rofi ]]; then
                    mkdir /home/"$sudo_user"/.config/rofi
                    cp assets/rofi/chrislee_dark.rasi /home/"$sudo_user"/.config/rofi/chrislee_dark.rasi
                    cp assets/rofi/config.rasi /home/"$sudo_user"/.config/rofi/config.rasi
                fi

				pacman -S --noconfirm papirus-icon-theme # icons for rofi menu

				# This block of code will check to see if nitrogen directory does NOT exist then create a directory for sudo_user variable, then
				# copy configs files to set a wallpaper and the wallpaper paths
				pacman -S --noconfirm nitrogen
				if [[ ! -d /home/"$sudo_user"/.config/nitrogen/ ]]; then
					mkdir /home/"$sudo_user"/.config/nitrogen/
					cp assets/nitrogen/nitrogen.cfg /home/"$sudo_user"/.config/nitrogen/
					sed -i  "s,/home/USER/,/home/$sudo_user/,g" /home/"$sudo_user"/.config/nitrogen/nitrogen.cfg
					cp assets/nitrogen/bg-saved.cfg /home/"$sudo_user"/.config/nitrogen/
					sed -i "s,/HOME,/home/$sudo_user,g" /home/"$sudo_user"/.config/nitrogen/bg-saved.cfg
					cp -r assets/nitrogen/wallpapers /home/"$sudo_user"/.config/nitrogen/
				fi

				pacman -S --noconfirm cronie
				systemctl enable cronie
				cp assets/cronie/USER_NAME_CRONTAB /var/spool/cron/"$sudo_user"
				chown "$sudo_user":"$sudo_user" /var/spool/cron/"$sudo_user"

				pacman -S --noconfirm themix-full-fit
				pacman -S --noconfirm lxappearance
				pacman -S --noconfirm qt5
				pacman -S --noconfirm qt6
				pacman -S --noconfirm qt5ct
				pacman -S --noconfirm qt6ct

				cp assets/theme/environment /etc/environment
				mkdir /home/$sudo_user/.config/gtk-3.0/
				cp assets/theme/settings.ini /home/$sudo_user/.config/gtk-3.0/settings.ini
				cp -r assets/theme/qt5ct /home/$sudo_user/.config/
				cp -r assets/theme/qt6ct /home/$sudo_user/.config/
				mkdir /home/$sudo_user/.themes
				cp -r assets/theme/oomox-Bluloco-dark /home/$sudo_user/.themes
				
				pacman -S --noconfirm nano-syntax-highlighting
				pacman -S --noconfirm lsd
				pacman -S --noconfirm alacritty # added as a defalut terminal
				pacman -S --noconfirm firefox # added as a defalut browser
				pacman -S --noconfirm dunst # for a notification system
				pacman -S --noconfirm picom # compositor for transparency etc..
				pacman -S --noconfirm xdg-user-dirs # auto create user dirs
				pacman -S --noconfirm base-devel
				pacman -S --noconfirm feh

				mkdir /home/$sudo_user/.config/alacritty/
				cp assets/alacritty/alacritty.yml /home/$sudo_user/.config/alacritty/
				mkdir /home/"$sudo_user"/.ssh
                cp assets/ssh_connections/config /home/"$sudo_user"/.ssh/config
                chown -R $sudo_user":$sudo_user" /home/"$sudo_user"/.ssh/

                cp -R assets/scripts /home/$sudo_user/.config/
                chown -R $sudo_user:$sudo_user /home/$sudo_user/.config
                chmod -R +x /home/$sudo_user/.config/scripts/*

                cp assets/bashrc/MY.bashrc /home/$sudo_user/.bashrc

				pacman -S --noconfirm git
				pacman -S --noconfirm make
				pacman -S --noconfirm gcc
				 cd /opt
				 sudo git clone https://aur.archlinux.org/yay.git
				 wait
				 sudo chown -R "$sudo_user":root ./yay
				 cd yay
				 sudo -u "$sudo_user" makepkg -si
				 sudo -u "$sudo_user" yay -S --noconfirm pulseaudio-control #added sudo -u $sudo_user
				 sudo -u "$sudo_user" yay -S --noconfirm xfce-polkit # added this to allow power,reboot and open apps that need sudo without a password
				 sudo -u "$sudo_user" yay -S --noconfirm shell-color-scripts
				cd $cd_from_yay_dir
				localectl --no-convert set-x11-keymap gb pc104 ,qwerty grp:win_space_toogle
				clear
				;;	
			"Install Packages" )
				clear
				while [[ -z "$sudo_user" ]]; do
					echo "A valid user needs to be entered if AUR package needs to be installed"
					read -r -p "please enter a valid username? " sudo_user
				done
	 			clear
				while [[ ! -d /home/"$sudo_user" ]]; do
					echo "A valid user needs to be entered if AUR package needs to be installed"
					read -r -p "YOU MUST enter a valid username? " sudo_user
					clear
				done

				PS3="Please choose a number: "
				echo "======================================================================================================="
				echo "Package Menu: Choose a Number to Install a Package(ONE Number at a Time)"
				echo "======================================================================================================="
				echo "                                                                                                       "
				options=("Alacritty(Installed by 'Install i3 with Requirements')" "Firefox(Installed by 'Install i3 with Requirements')" "VLC" "Gparted" "GIMP" "VirtualBox" "virt manager (kvm)" "Audacity" "Discord" "FileZilla" "qBittorrent" "Ranger" "ARandR" "Caja" "Tilda" "Opera" "TeamViewer(AUR)" "Sublime Text 4(AUR)" "Brave(AUR)" "TimeShift(AUR)" "Install All" "Back" "Reboot" "Poweroff" "Exit Script")
				select packages in "${options[@]}"
				do
					case $packages in
						"Alacritty(Installed by 'Install i3 with Requirements')" )
							pacman -S --noconfirm alacritty
							clear
							;;
						"Firefox(Installed by 'Install i3 with Requirements')" )
							pacman -S --noconfirm firefox
							clear
							;;
						"VLC" )
							pacman -S --noconfirm vlc
							clear
							;;
						"Gparted" )
							pacman -S --noconfirm gparted
							clear
							;;
						"GIMP" )
							pacman -S --noconfirm gimp
							clear
							;;
						"VirtualBox" )
							pacman -S --noconfirm virtualbox
							clear
							;;
						"virt manager (kvm)" )
							pacman -S --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat iptables libguestfs qemu-emulators-full
							usermod -aG libvirt $sudo_user
							systemctl enable libvirtd
							clear
							;;
						"Audacity" )
							pacman -S --noconfirm audacity
							clear
							;;
						"Discord" )
							pacman -S --noconfirm discord
							clear
							;;
						"FileZilla" )
							pacman -S --noconfirm filezilla
							clear
							;;
						"qBittorrent" )
							pacman -S --noconfirm qbittorrent
							clear
							;;
						"Ranger" )
							pacman -S --noconfirm ranger
							clear
							;;
						"ARandR" )
							pacman -S --noconfirm arandr
							clear
							;;
						"Caja" )
							pacman -S --noconfirm caja
							pacman -S --noconfirm gvfs-smb
							cp assets/caja/caja.desktop /usr/share/applications/caja.desktop
							cp assets/caja/caja.png /usr/share/caja/patterns/caja.png
							clear
							;;
						"Tilda" )
							pacman -S --noconfirm tilda
							mkdir /home/"$sudo_user"/.config/tilda/
							cp assets/tilda/config_0 /home/$sudo_user/.config/tilda/
							chown -R "$sudo_user":"$sudo_user" /home/"$sudo_user"/.config/
							clear
							;;
						"Opera" )
							pacman -S --noconfirm opera
							clear
							;;
						"TeamViewer(AUR)" )
							sudo -u "$sudo_user" yay -S --noconfirm teamviewer
							clear
							;;
						"Sublime Text 4(AUR)" )
							sudo -u "$sudo_user" yay -S --noconfirm sublime-text-4
							clear
							;;		
						"Brave(AUR)" )
							sudo -u "$sudo_user" yay -S --noconfirm brave-bin
							clear
							;;
						"TimeShift(AUR)" )
							sudo -u "$sudo_user" yay -S --noconfirm timeshift
							# timeshift --create --comments "Snapshot created by install script after installation completed"
							clear
							;;
						"Install All" )
							pacman -S --noconfirm terminator
							pacman -S --noconfirm firefox
							pacman -S --noconfirm vlc
							pacman -S --noconfirm gparted					
							pacman -S --noconfirm gimp
							pacman -S --noconfirm virtualbox
							pacman -S --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat iptables libguestfs qemu-emulators-full
							usermod -aG libvirt $sudo_user
							systemctl enable libvirtd
							pacman -S --noconfirm audacity
							pacman -S --noconfirm discord
							pacman -S --noconfirm filezilla						
							pacman -S --noconfirm qbittorrent
							pacman -S --noconfirm ranger
							pacman -S --noconfirm arandr

							pacman -S --noconfirm caja
							pacman -S --noconfirm gvfs-smb
							cp assets/caja/caja.desktop /usr/share/applications/caja.desktop
							cp assets/caja/caja.png /usr/share/caja/patterns/caja.png

							pacman -S --noconfirm tilda
							mkdir /home/"$sudo_user"/.config/tilda/
							cp assets/tilda/config_0 /home/"$sudo_user"/.config/tilda/
							chown -R "$sudo_user":"$sudo_user" /home/"$sudo_user"/.config/	
							clear

							pacman -S --noconfirm opera
							clear

							sudo -u "$sudo_user" yay -S --noconfirm teamviewer
							sudo -u "$sudo_user" yay -S --noconfirm sublime-text-4

							sudo -u "$sudo_user" yay -S --noconfirm brave-bin

							sudo -u "$sudo_user" yay -S --noconfirm timeshift
							clear
							;;
						"Back" )
							exec "$script_dir"/"$script_file"
							;;
						"Reboot" )
							if [[ -f /usr/bin/timeshift ]]; then
								read -p "Would you like to create a snapshot with timeshift? " timeshift
								while [[ $timeshift != y ]] && [[ $timeshift != n ]]; do
									echo "Please Enter y or n"
									read -p "Would you like to create a snapshot with timeshift? " timeshift
								done
								if [[ $timeshift = y ]]; then
									timeshift --create --comments "Snapshot created by install script after installation completed"
								fi
							fi
							reboot
							;;			
						"Poweroff" )
								if [[ -f /usr/bin/timeshift ]]; then
								read -p "Would you like to create a snapshot with timeshift? " timeshift
								while [[ $timeshift != y ]] && [[ $timeshift != n ]]; do
									echo "Please Enter y or n"
									read -p "Would you like to create a snapshot with timeshift? " timeshift
								done
								if [[ $timeshift = y ]]; then
									timeshift --create --comments "Snapshot created by install script after installation completed"
								fi
							fi
							poweroff
							;;
						"Exit Script" )
							if [[ -f /usr/bin/timeshift ]]; then
								read -p "Would you like to create a snapshot with timeshift? " timeshift
								while [[ $timeshift != y ]] && [[ $timeshift != n ]]; do
									echo "Please Enter y or n"
									read -p "Would you like to create a snapshot with timeshift? " timeshift
								done
								if [[ $timeshift = y ]]; then
									timeshift --create --comments "Snapshot created by install script after installation completed"
								fi
							fi
							exit
							;;
					esac
					REPLY=
				done
				clear
				;;
			"Reboot" )
				if [[ -f /usr/bin/timeshift ]]; then
					read -p "Would you like to create a snapshot with timeshift? " timeshift
					while [[ $timeshift != y ]] && [[ $timeshift != n ]]; do
						echo "Please Enter y or n"
						read -p "Would you like to create a snapshot with timeshift? " timeshift
					done
					if [[ $timeshift = y ]]; then
						timeshift --create --comments "Snapshot created by install script after installation completed"
					fi
				fi
				reboot
				;;			
			"Poweroff" )
				if [[ -f /usr/bin/timeshift ]]; then
					read -p "Would you like to create a snapshot with timeshift? " timeshift
					while [[ $timeshift != y ]] && [[ $timeshift != n ]]; do
						echo "Please Enter y or n"
						read -p "Would you like to create a snapshot with timeshift? " timeshift
					done
					if [[ $timeshift = y ]]; then
						timeshift --create --comments "Snapshot created by install script after installation completed"
					fi
				fi
				poweroff
				;;
			"Exit Script" )
				if [[ -f /usr/bin/timeshift ]]; then
					read -p "Would you like to create a snapshot with timeshift? " timeshift
					while [[ $timeshift != y ]] && [[ $timeshift != n ]]; do
						echo "Please Enter y or n"
						read -p "Would you like to create a snapshot with timeshift? " timeshift
					done
					if [[ $timeshift = y ]]; then
						timeshift --create --comments "Snapshot created by install script after installation completed"
					fi
				fi
				exit
				;;
		esac
		REPLY=
	 done
	clear
fi