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

# This file contains global functions
# To use these functions just import this file 
# source 00-centos-functions.sh

#Declaring Functions 

#This function is an easier way to reuse the yum code. 
install_packages()
{
 tput setaf 2
 echo "Installing packages: ${@}"
 tput sgr0
 yum -y update && yum -y install ${@}
 if [ $? -eq 0 ]; then
  tput setaf 2
  echo "Packages successfully installed."
  tput sgr0
 else
  tput setaf 1
  echo "Packages failed to install!"
  tput sgr0
  exit 1
 fi
}

