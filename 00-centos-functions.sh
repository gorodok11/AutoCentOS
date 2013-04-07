#!/bin/bash
# This file contains global functions
# To use these functions just import this file 
# source 00-centos-functions.sh

#Declaring Functions - This function is an easier way to reuse the yum code. 
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

#----------------------------------------------------

