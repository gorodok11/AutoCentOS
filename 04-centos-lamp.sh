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

declare -a packages=( httpd php php-common mysql php-mysql mysql-server mysql-bench mysql-devel php-gd php-cli  php-pear.noarch php-pear-DB.noarch php-pear-File.noarch phpmyadmin );
install_packages ${packages[@]}

tput setaf 2
echo "starting apache and mysql, and adding them to runlevel 3 via chkconfig"
tput sgr0

service mysqld start
service httpd start
chkconfig mysqld --add
chkconfig httpd --add
chkconfig mysqld --level 3 on
chkconfig httpd --level 3 on

tput setaf 2
echo "Running the mysql_secure_install script."
echo "Set root password. Disable guest login. Remove test databases. Activate changes."
echo "By default root password is empty."
tput sgr0

/usr/bin/mysql_secure_installation
if [ $? -eq 0 ]; then
  tput setaf 2
  echo "Mysql updated and secured. Be sure to store the root mysql user password somewhere safe."
  tput sgr0
else
  tput setaf 1
	echo "Something went wrong somewhere. Re-run the script /usr/bin/mysql_secure_installation then run this script again. Aborting. "
  tput sgr0
  exit 1
fi

service mysqld restart

echo "<?php
phpinfo();
?>" >/var/www/html/info.php

tput setaf 2
echo "Open in browser http://your-server-ip/info.php for testing PHP."
echo "Open in browser http://your-server-ip/phpMyAdmin/ to administrate mySQL databases."
tput sgr0

# To do: prompt user to insert allowed IP
tput setaf 3
echo "After installation maybe you will receive the next error:"
echo "You don't have permission to access /phpmyadmin/ on this server."
echo "To fix this, you need to edit /etc/httpd/conf.d/phpMyAdmin.conf"
echo "nano /etc/httpd/conf.d/phpMyAdmin.conf"
echo "Add your allowed IPs separated by spaces in <Directory /usr/share/phpMyAdmin/> section"
echo "Example: Allow from 127.0.0.1 10.1.3.53"
tput sgr0




