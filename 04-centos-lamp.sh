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

declare -a packages=( httpd php php-common mysql php-mysql mysql-server phpmyadmin );
install_packages ${packages[@]}

chkconfig httpd on
chkconfig mysqld on
service mysqld start
service httpd start

tput setaf 2
echo "Set root password. Disable guest login. Remove test databases. Activate changes."
echo "By default root password is empty."
tput sgr0

/usr/bin/mysql_secure_installation

service mysqld restart

echo "<?php
phpinfo();
?>" >/var/www/html/info.php

tput setaf 2
echo "Open in browser http://your_IP/info.php for testing PHP."
echo "Open in browser http://your_IP/phpmyadmin to administrate mySQL databases."
tput sgr0
