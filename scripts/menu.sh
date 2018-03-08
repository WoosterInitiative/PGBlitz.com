#!/bin/bash

### remove exit hold
#rm -r /var/plexguide/exit.yes 1>/dev/null 2>&1
echo "export NCURSES_NO_UTF8_ACS=1" >> /etc/bash.bashrc.local
mkdir /var/plexguide/ 1>/dev/null 2>&1
#sudo apt-get install whiptail -y 1>/dev/null 2>&1
### incase it's not installed prior
file="/usr/bin/dialog"
if [ -e "$file" ]
then
   clear 1>/dev/null 2>&1
else
   clear
   echo "Installing Dialog"
   apt-get install dialog 1>/dev/null 2>&1
   export NCURSES_NO_UTF8_ACS=1
   echo "export NCURSES_NO_UTF8_ACS=1" >> /etc/bash.bashrc.local
fi

sudo rm -r /opt/plexguide/menus/version/main.sh && sudo mkdir -p /opt/plexguide/menus/version/ && sudo wget --force-directories -O /opt/plexguide/menus/version/main.sh https://raw.githubusercontent.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server/Version-5/menus/version/main.sh 1>/dev/null 2>&1

# copying rclone config to user incase bonehead is not root
cp /root/.config/rclone/rclone.conf ~/.config/rclone/rclone.conf

# Checking to see if VNC Container is Running
#file="/var/plexguide/vnc.yes"
#if [ -e "$file" ]
#then
#whiptail --title "Warning" --msgbox "You still have the VNC Container Running! Make sure to Destroy the Container via the VNC Menu!" 9 66
#fi

file="/var/plexguide/ask.yes"
if [ -e "$file" ]
then
   clear
else
   bash /opt/plexguide/menus/version/main.sh
   clear
      echo "1. Please STAR PG via http://github.plexguide.com"
      echo "2. Join the PG Discord via http://discord.plexguide.com"
      echo "3. Donate to PG via http://donate.plexguide.com"
      echo ""
      echo "TIP : Press Z, then [ENTER] in the Menus to Exit"
      echo "TIP : Menu Letters Displayed are HotKeys"
      echo "TIP : Update Plexguide Anytime, type: sudo pgupdate"
      echo "NOTE: Restart the Program Anytime, type: sudo plexguide"
      echo ""
   exit 0
fi

file="/var/plexguide/dep42.yes"
if [ -e "$file" ]
then
   touch /var/plexguide/message.no
else
   bash /opt/plexguide/scripts/baseinstall/main.sh
fi

## starup Message

bash /opt/plexguide/scripts/checker/main.sh
bash /opt/plexguide/menus/startup/message.sh
bash /opt/plexguide/menus/main.sh
