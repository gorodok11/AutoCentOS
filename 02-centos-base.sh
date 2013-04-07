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

#Installing devellopment packages
declare -a packages=( ethtool nmap httpd make gcc libtool bind-utils ntp pcre-devel libnet-devel libdnet-devel libpcap-devel flex bison kernel-devel autoconf libxml2-devel );
install_packages ${packages[@]}

chkconfig ntpd on
ntpdate pool.ntp.org
service ntpd start

# Temporarily set selinux to permissive
setenforce permissive
# To turn selinux off immediately, without rebooting use:
# setenforce 0

#Installing some console tools
declare -a packages=( vim nano mc htop man system-config-firewall-tui );
install_packages ${packages[@]}
