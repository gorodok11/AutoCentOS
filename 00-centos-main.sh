#!/bin/bash
########################################################
#     ___       __       _____         __  ____  ____  #
#    / _ |__ __/ /____  / ___/__ ___  / /_/ __ \/ __/  #
#   / __ / // / __/ _ \/ /__/ -_) _ \/ __/ /_/ /\ \    #
#  /_/ |_\_,_/\__/\___/\___/\__/_//_/\__/\____/___/    #
#                                                      #
#                     Frunza Igor                      #
#                         2013                         #
########################################################

# Some copyright info:
# Logo created with http://patorjk.com/software/taag/

# Importing functions
source 00-centos-functions.sh

# Clear screen
tput clear

# Move cursor to screen location X,Y (top left is 0,0)
tput cup 1 0
# Change text color
tput setaf 4

echo "     ___       __       _____         __  ____  ____"
echo "    / _ |__ __/ /____  / ___/__ ___  / /_/ __ \/ __/"
echo "   / __ / // / __/ _ \/ /__/ -_) _ \/ __/ /_/ /\ \  "
echo "  /_/ |_\_,_/\__/\___/\___/\__/_//_/\__/\____/___/  "
echo "                                                    "  
echo "               Frunza Igor, 2013                    "
echo "____________________________________________________"

# Reset text color settings
tput sgr0
# Moving cursor to 10 0
tput cup 10 0
# Set bold mode
tput bold
echo "Auto install a complete server system for network monitoring"
echo "Based on CentOS 6.x"

while true; do
     read -p "Continue install? (y/n)" warncheck
     case $warncheck in
          [Yy]* ) break;;
          [Nn]* ) echo "Cancelling."; exit;;
          * ) tput setaf 1;  echo "Please answer yes or no."; tput sgr0;;
     esac
done

tput clear
tput sgr0
tput rc
tput cup 0 0
tput setaf 2
echo "Installing..."
tput sgr0
tput clear

#----------------------------------------------------

echo "Check config file..."
while [ $# -gt 0 ]; do
        case $1 in
                -c)
                        if [ -r "$2" ]; then
                                source "$2"
                                shift 2
                        else
                                tput setaf 1
                                ${ECHO} "Unable to read config file \"$2\""
                                tput sgr0
                                exit 1
                        fi
                        ;;
                *)
                        tput setaf 1
                        ${ECHO} "Unknown option \"$1\""
                        tput sgr0
                        exit 2
                        ;;
        esac
done

echo "Loading config file..."

if [ $# = 0 ]; then
        SCRIPTPATH=$(cd $(dirname $0) && pwd);
        source $SCRIPTPATH/AutoCentOS.conf
fi;

#----------------------------------------------------

echo "OS Version Check."
     release=`cat /etc/redhat-release|awk '{print $3}' | cut -d"." -f1`
     if [ $release != "6" ]
          then
               tput setaf 1
               echo "This is not CentOS 6.x. This script has not been tested on other platforms."
               tput sgr0
               while true; do
                   tput setaf 1
                   read -p "Continue? (y/n)" warncheck
                   tput sgr0
                   case $warncheck in
                       [Yy]* ) break;;
                       [Nn]* ) echo "Cancelling."; exit;;
                       * ) echo "Please answer yes or no.";;
                   esac
                done
          else
               tput setaf 2
               echo "Version is 6.3. Good to go."
               tput sgr0
     fi

#----------------------------------------------------

tput setaf 2
echo "Checking internet connectivity (pinging google.com)"
tput sgr0
     ping google.com -c1 2>&1 >> /dev/null
     if [ $? -eq 0 ]; then
          tput setaf 2
          echo "Connectivity looks good!"
          tput sgr0
     else
          tput setaf 1
          echo "Ping to google has failed. Please verify you have network connectivity or ICMP outbound is allowed. Seriously, what harm is it going to do?"
          tput sgr0
       exit 1
     fi

#----------------------------------------------------

#assumes script is ran as root. root check performed via use of whoami. 
#checks for a response of "root" if user isn't root, script exits and notifies user it needs to be ran as root.

tput setaf 2
echo "User Check"
tput sgr0
     if [ $(whoami) != "root" ]
          then
               tput setaf 1
               echo "This script must be ran with root priveleges either as the root user or via sudo."
               tput sgr0
  	exit 1
          else
               tput setaf 2
               echo "We are root."
               tput sgr0
     fi

#----------------------------------------------------

# To do: 

tput setaf 2
echo "Checking to ensure sshd is running."
tput sgr0
  if [ $(/bin/ps -ef |/bin/grep sshd |/usr/bin/wc -l) -gt 1 ]
		then
      tput setaf 2
			echo "sshd is running "
      tput sgr0
		else
      tput setaf 3
			echo "sshd isn't running... The script can continue, but in most cases, sshd is use for remotely managing snort sensors."
      tput sgr0
   fi

#----------------------------------------------------

/usr/bin/which wget 2>&1 >> /dev/null
if [ $? -ne 0 ] 
  then 
    tput setaf 2
    echo "wget not found. Install wget?"
    tput sgr0
		case $wget_install in
			[yY] | [yY][Ee][Ss])
				install_packages wget
				;;
			* )
        tput setaf 1
				echo "Either you selected no or I didn't understand. Wget is required to continue. Aborting."
        tput sgr0
                exit 1
                ;;
        esac
	else
        tput setaf 2
        echo "found wget."
        tput sgr0
fi

#----------------------------------------------------

#Here we call yum -y upgrade to ensure all repos and stock software is fully updated.
#For consistency, if the command chain exits on anything other than a 0 exit code, 
#we notify the user that updates were not successfully installed.

tput setaf 2
echo "Performing yum update (with -y switch)"
tput sgr0
yum -y update 
if [ $? -eq 0 ]; then
  tput setaf 2
  echo "Packages and repos are fully updated."
  tput sgr0
else
  tput setaf 1
	echo "yum upgrade failed."
  tput sgr0
fi

#----------------------------------------------------

#Installing additional repositories

#bash 01-centos-repositories.sh
#bash 02-centos-base.sh
#bash 03-centos-webmin.sh
#bash 04-centos-lamp.sh
#bash 05-centos-desktop-gnome.sh
