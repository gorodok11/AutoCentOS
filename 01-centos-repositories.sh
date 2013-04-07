#!/bin/bash
#Install repsitories

source 00-centos-functions.sh

install_EPEL ()
{
tput clear
tput setaf 2
echo "Installing EPEL repossitory."
tput sgr0
arch=`uname -i`
case $arch in
  i386 )
                wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
                ;;
        x86_64 )
                wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
                ;;
esac
rpm -Uvh epel-release-6-8.noarch.rpm
rm epel-release-6-8.noarch.rpm
sed -i '/enabled=1/a\priority=10\' /etc/yum.repos.d/epel.repo
}

install_REMI ()
{
tput clear
tput setaf 2
echo "Installing REMI repossitory."
tput sgr0
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6.rpm
rm remi-release-6.rpm
sed -i "/\[remi\]/,/\[.*\]/s/enabled=.*/enabled=1/" /etc/yum.repos.d/remi.repo
sed -i '/enabled=1/a\priority=10\' /etc/yum.repos.d/remi.repo
}

yum install -y yum-priorities
#Setting base priorities
sed -i '/enabled=1/a\priority=1\' /etc/yum.repos.d/CentOS-Base.repo


while true; do
  tput clear
  tput cup 1 0
  tput setaf 4

  echo "     ___       __       _____         __  ____  ____"
  echo "    / _ |__ __/ /____  / ___/__ ___  / /_/ __ \/ __/"
  echo "   / __ / // / __/ _ \/ /__/ -_) _ \/ __/ /_/ /\ \  "
  echo "  /_/ |_\_,_/\__/\___/\___/\__/_//_/\__/\____/___/  "
  echo "                                                    "
  echo "               Frunza Igor, 2013                    "
  echo "____________________________________________________"

  tput sgr0
  tput cup 10 0
  tput bold

  echo "Select additional repositories to install:"
  echo "1. EPEL repositories"
  echo "2. REMI repositories"
  echo "3. Install all repositories"
  echo "4. Exit."
  tput sgr0
  read -p "Type a number from menu to install:" reposelection

  case "$reposelection" in
          1 ) install_EPEL;;
          2 ) install_REMI;;
          3 ) install_EPEL; install_REMI;;
          4 ) echo "Cancelling..."; break; exit ;;
          * ) tput setaf 1;  echo "Please type a number from menu list."; tput sgr0;;
  esac
done

